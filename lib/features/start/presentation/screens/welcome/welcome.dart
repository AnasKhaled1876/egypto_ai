import 'package:egypto/config/theme/colors.dart';
import 'package:egypto/config/widgets/app_bar.dart';
import 'package:egypto/config/widgets/elevated_button.dart';
import 'package:egypto/features/start/presentation/screens/login_or_create.dart';
import 'package:egypto/shared/widgets/texts/terms_of_use.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../../shared/widgets/buttons/change_theme.dart';
import '../../../../auth/cubit/auth_cubit.dart';
import '../../../../../shared/widgets/buttons/change_language_app_bar.dart';
import '../../../../../shared/widgets/word_logo.dart';
import '../../../../home/presentation/screens/home.dart';

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
      backgroundColor: const Color(0xFF101010),
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBarWidget(),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: const Color(0xFF0F0F0F))),
            // Positioned.fill(
            //   top: 0,
            //   child: Image.asset(
            //     "assets/images/pyramid.png",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.39, 0.61],
                    begin: const Alignment(0, -0.5),
                    end: const Alignment(0, 1),
                    colors: [
                      const Color(0xFF0F0F0F).withValues(alpha: 0.1),
                      const Color(0xFF0F0F0F),
                    ],
                  ),
                ),
              ),
            ),
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChangeLanguageAppBarButton(),
                            ChangeThemeButton(),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Spacer(),
                        const Hero(tag: 'word-logo', child: WordLogo()),
                        const SizedBox(height: 20),
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
                                              RadialGradient(
                                                center: Alignment.center,
                                                radius: 13,
                                                colors: [
                                                  primaryColor.shade900,
                                                  primaryColor.shade500,
                                                  Colors.white,
                                                  secondaryColor.shade300,
                                                ],

                                                stops: const [
                                                  0.0,
                                                  0.22,
                                                  0.60,
                                                  0.86,
                                                ],
                                              ).createShader(
                                                const Rect.fromLTWH(
                                                  0,
                                                  0,
                                                  180,
                                                  120,
                                                ),
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
                          style: defaultElevatedButtonStyle(
                            context: context,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () => context.pushNamed(
                            LoginOrCreateAccountScreen.routeName,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.get_started,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const TermsOfUseRichText(),
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
