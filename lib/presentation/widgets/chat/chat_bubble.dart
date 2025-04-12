import 'package:egypto_ai/locator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isUserMessage,
  });

  final String message;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isUserMessage ? null : Colors.transparent,
      decoration:
          isUserMessage
              ? ShapeDecoration(
                color: const Color(0xFF141414),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      isUserMessage
                          ? BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                          : BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                ),
              )
              : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUserMessage) ...[
            ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [
                      Color(0xFF618B4A),
                      Color(0xFF4E7F62),
                      Color(0xFF20639B),
                      Color(0xFF1C2895),
                    ],
                    stops: [0.0, 0.5, 0.7, 1.1],
                    begin:
                        localeNotifier.value.languageCode == 'ar'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                    end:
                        localeNotifier.value.languageCode == 'ar'
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  ),
              blendMode: BlendMode.srcIn,
              child: Text(
                AppLocalizations.of(context)!.egypto,
                style: TextStyle(
                  color: const Color(0xFF618B4A),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
          GptMarkdown(
            message,
            textDirection:
                localeNotifier.value.languageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'SomarSans',
              fontWeight: FontWeight.w400,
            ),
          ),
          if (!isUserMessage) ...[
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(200),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: message));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.copied),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFF1E1E1E),
                        ),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                    child: SvgPicture.asset("assets/icons/copy.svg"),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
