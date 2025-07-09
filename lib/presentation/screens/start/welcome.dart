import 'dart:ui';

import 'package:egypto/config/widgets/elevated_button.dart';
import 'package:egypto/presentation/screens/start/start.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../l10n/app_localizations.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/change_language_app_bar.dart';
import '../../widgets/misc/word_logo.dart';
import '../home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = 'welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Positioned(
              top: -300,
              left: 0,
              right: 0,
              child: BackdropFilter(
                filter: ImageFilter.dilate(radiusX: 200, radiusY: 200),
                child: SvgPicture.asset(
                  "assets/icons/top_ellipse.svg",
                  height: 576,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
            //     child: SvgPicture.asset(
            //       "assets/icons/bottom_ellipse.svg",
            //       height: 672,
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                left: 28,
                right: 28,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SocialSignInSuccessState) {
                      context.pushNamed(HomeScreen.routeName);
                    }
                    if (state is EmailNoExistsState) {
                      // context.pushNamed(RegisterScreen.routeName);
                    }
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 17),
                        const Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: ChangeLanguageAppBarButton(),
                        ),
                        const SizedBox(height: 66),
                        Hero(
                          tag: 'logo',
                          child: SvgPicture.asset(
                            "assets/icons/logo.svg",
                            height: 60,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Hero(tag: 'word-logo', child: WordLogo()),
                        const Spacer(),
                        SizedBox(
                          width: 320,
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.first} ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.ai,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        foreground: Paint()
                                          ..shader =
                                              const RadialGradient(
                                                colors: [
                                                  Color(0xFF00A3A4),
                                                  Color(0xFF00BCA1),
                                                  Color(0xFF20639B),
                                                  Color(0xFF1C2895),
                                                ],
                                                stops: [0, 0.32, 0.74, 1],
                                                center: Alignment.topLeft,
                                                radius: 10,
                                              ).createShader(
                                                const Rect.fromLTWH(0, 0, 180, 120),
                                              ),
                                      ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${AppLocalizations.of(context)!.chatbotEgypt}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 66),
                        ElevatedButton(
                          style: gradientElevatedButtonStyle(context: context),
                          onPressed: () =>
                              context.pushNamed(StartScreen.routeName),
                          child: Text(
                            AppLocalizations.of(context)!.get_started,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: defaultElevatedButtonStyle(
                            context: context,
                            backgroundColor: Theme.of(context).cardColor,
                          ),
                          onPressed: () =>
                              context.pushNamed(StartScreen.routeName),
                          child: Text(
                            AppLocalizations.of(context)!.login,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
