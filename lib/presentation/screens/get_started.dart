import 'package:egypto_ai/presentation/screens/start/welcome.dart';
import 'package:egypto_ai/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../config/resources/colors.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/bubble_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  static const String routeName = 'get-started';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 28, right: 28, top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'logo',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/logo.svg",
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 12),
                      SvgPicture.asset(
                        "assets/icons/word-logo.svg",
                        height: 35,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      transform:
                          Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-0.10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 40,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.42),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 7.47,
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            )!.programming.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'SomarSans',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.09,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 1),

                SizedBox(
                  width: 320,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${AppLocalizations.of(context)!.first} ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textSize * 64,
                            fontFamily: 'SomarSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.ai,
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: textSize * 64,
                            fontFamily: 'SomarSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' ${AppLocalizations.of(context)!.chatbotEgypt}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textSize * 64,
                            fontFamily: 'SomarSans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(flex: 2),
                BubbleButton(
                  title: AppLocalizations.of(context)!.get_started,
                  onTap: () => context.pushNamed(WelcomeScreen.routeName),
                ),
                SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
