import 'package:egypto/config/widgets/elevated_button.dart';
import 'package:egypto/features/auth/presentation/screens/otp.dart';
import 'package:egypto/features/start/presentation/widgets/or_divider.dart';
import 'package:egypto/shared/widgets/base/app_bar.dart';
import 'package:egypto/shared/widgets/word_logo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../../../shared/widgets/indicators/loading_animation.dart';
import '../../../../shared/widgets/texts/terms_of_use.dart';
import '../../../home/presentation/screens/home.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  static const String routeName = 'start';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(title: WordLogo(), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                    context.pushNamed(OTPScreen.routeName);
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
                      SizedBox(
                        width: 285,
                        child: Text(
                          AppLocalizations.of(context)!.loginOrCreateAccount,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 29,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Text(
                        AppLocalizations.of(context)!.pleaseEnterYourEmail,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        textAlign: TextAlign.left,
                        textDirection: TextDirection.ltr,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'example@mail.com',
                          suffixIcon: Icon(Icons.email_outlined, size: 20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterYourEmail;
                          }
                          final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterYourEmail;
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (_formKey.currentState!.validate()) {
                            AuthCubit.get(context).checkEmail(email: value);
                          }
                        },
                      ),

                      AnimatedSize(
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          height: state is EmailExistsState ? null : 0,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: state is EmailExistsState
                                  ? null
                                  : InputBorder.none,
                              enabledBorder: state is EmailExistsState
                                  ? null
                                  : InputBorder.none,
                              hintText: AppLocalizations.of(context)!.password,
                            ),
                            validator: state is EmailExistsState
                                ? (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.pleaseEnterYourPassword;
                                    }
                                    return null;
                                  }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      AbsorbPointer(
                        absorbing:
                            state is CheckEmailLoadingState ||
                            state is LoginLoadingState,
                        child: ElevatedButton(
                          style: defaultElevatedButtonStyle(
                            context: context,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              AuthCubit.get(
                                context,
                              ).checkEmail(email: _emailController.text);
                            }
                          },
                          child: state is CheckEmailLoadingState
                              ? const LoadingAnimationWidget(size: 10)
                              : Text(
                                  AppLocalizations.of(context)!.login,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const OrDivider(),
                      const SizedBox(height: 24),
                      AbsorbPointer(
                        absorbing: state is SocialSignInLoadingState,
                        child: ElevatedButton(
                          style: defaultElevatedButtonStyle(context: context),
                          onPressed: () async {
                            await GoogleSignIn.instance.authenticate().then((
                              value,
                            ) {
                              if (value.authentication.idToken != null) {
                                if (context.mounted) {
                                  context.read<AuthCubit>().signInWithSocial(
                                    email: value.email,
                                    providerId: value.id,
                                    name: value.displayName ?? '',
                                    photoUrl: value.photoUrl,
                                  );
                                }
                              }
                            });
                          },
                          child: state is SocialSignInLoadingState
                              ? const CircularProgressIndicator.adaptive()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/google.svg",
                                      width: 24,
                                      height: 24,
                                    ),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.continueWithGoogle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AbsorbPointer(
                        absorbing: state is SocialSignInLoadingState,
                        child: ElevatedButton(
                          style: defaultElevatedButtonStyle(context: context),
                          onPressed: () async {
                            await GoogleSignIn.instance.authenticate().then((
                              value,
                            ) {
                              if (value.authentication.idToken != null) {
                                if (context.mounted) {
                                  context.read<AuthCubit>().signInWithSocial(
                                    email: value.email,
                                    providerId: value.id,
                                    name: value.displayName ?? '',
                                    photoUrl: value.photoUrl,
                                  );
                                }
                              }
                            });
                          },
                          child: state is SocialSignInLoadingState
                              ? const CircularProgressIndicator.adaptive()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/apple.svg",
                                      width: 24,
                                      height: 24,
                                    ),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.continueWithGoogle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      const SizedBox(height: 56),
                      const TermsOfUseRichText(),
                      const SizedBox(height: 36),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
