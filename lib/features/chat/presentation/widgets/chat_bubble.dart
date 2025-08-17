import 'package:egypto/config/di/locator.dart';
import 'package:egypto/shared/widgets/indicators/loading_animation.dart';
import 'package:egypto/shared/utils/string_formatters.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../../../../l10n/app_localizations.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDot(context, 0),
        const SizedBox(width: 4),
        _buildDot(context, 1),
        const SizedBox(width: 4),
        _buildDot(context, 2),
      ],
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
        shape: BoxShape.circle,
      ),
      child: AnimatedOpacity(
        opacity: 0.5 + (0.5 * ((index + 1) / 3)),
        duration: Duration(milliseconds: 500 + (index * 200)),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.message, required this.isUserMessage, super.key,
    this.isTyping = false,
    this.isLoading = false,
  });

  final String message;
  final bool isUserMessage;
  final bool isTyping;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: isUserMessage
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8)
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isUserMessage ? null : Colors.transparent,
      decoration: isUserMessage
          ? ShapeDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: isUserMessage
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : const BorderRadius.only(
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
            Row(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      LinearGradient(
                        colors: const [
                          Color(0xFF618B4A),
                          Color(0xFF4E7F62),
                          Color(0xFF20639B),
                          Color(0xFF1C2895),
                        ],
                        stops: const [0.0, 0.32, 0.74, 1],
                        begin: localeNotifier.value.languageCode == 'ar'
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        end: localeNotifier.value.languageCode == 'ar'
                            ? const Alignment(-1.5, 0.3)
                            : const Alignment(1.5, 0.3),
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  blendMode: BlendMode.srcIn,
                  child: SelectableText(
                    AppLocalizations.of(context)!.egypto,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (isTyping || isLoading) const LoadingAnimationWidget(),
              ],
            ),
            const SizedBox(height: 8),
          ],
          GptMarkdown(
            isUserMessage ? message : formatBotMessage(message),

            textDirection: localeNotifier.value.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            orderedListBuilder: (context, no, child, config) => Column(
              crossAxisAlignment: localeNotifier.value.languageCode == 'ar'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: localeNotifier.value.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Text(
                      '$no. ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(child: child),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
            unOrderedListBuilder: (context, child, config) => Column(
              crossAxisAlignment: localeNotifier.value.languageCode == 'ar'
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: localeNotifier.value.languageCode == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(child: child),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (!isUserMessage && !isTyping && message.isNotEmpty) ...[
            const SizedBox(height: 20),
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
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFF1E1E1E),
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
