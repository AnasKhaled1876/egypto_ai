import 'package:egypto_ai/presentation/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:egypto_ai/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

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
                            color: const Color(0xFF618B4A),
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
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => context.pushNamed(HomeScreen.routeName),
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 17,
                          ),
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF618B4A),
                                Color(0xFF4E7F62),
                                Color(0xFF20639B),
                                Color(0xFF1C2895),
                              ],
                              stops: [0.0, 0.4, 0.7, 1.0],
                              begin: AlignmentDirectional(-1.0, 1.0),
                              end: AlignmentDirectional(1.0, -1.0),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2000),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.get_started,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
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
