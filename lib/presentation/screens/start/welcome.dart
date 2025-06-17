import 'package:egypto_ai/config/widgets/elevated_button.dart';
import 'package:egypto_ai/locator.dart';
import 'package:egypto_ai/presentation/screens/auth/register.dart';
import 'package:egypto_ai/presentation/widgets/start/or_divider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../l10n/app_localizations.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/loading_animation.dart';
import '../../widgets/terms_of_use.dart';
import '../home.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String routeName = 'welcome';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                      context.pushNamed(RegisterScreen.routeName);
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
                        SizedBox(height: 52),
                        Hero(
                          tag: 'logo',
                          child: SvgPicture.asset(
                            "assets/icons/logo.svg",
                            width: 48,
                            height: 48,
                          ),
                        ),
                        SizedBox(width: 12),
                        Hero(
                          tag: 'word-logo',
                          child: SvgPicture.asset(
                            "assets/icons/word-logo.svg",
                            height: 65,
                          ),
                        ),
                        SizedBox(height: 100),
                        Text(
                          AppLocalizations.of(context)!.firstlyYourEmail,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          textAlign: TextAlign.center,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'name@email.com',
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
                            AuthCubit.get(context).checkEmail(email: value);
                          },
                        ),
                        if (state is EmailExistsState) SizedBox(height: 14),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            height: state is EmailExistsState ? null : 0,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(
                                  context,
                                )!.password,
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
                                AuthCubit.get(context).checkEmail(email: value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        ElevatedButton(
                          style: defaultElevatedButtonStyle(context: context),
                          onPressed: () {
                            AuthCubit.get(
                              context,
                            ).checkEmail(email: _emailController.text);
                          },
                          child: state is CheckEmailLoadingState
                              ? LoadingAnimationWidget(size: 10)
                              : Text(AppLocalizations.of(context)!.login),
                        ),
                        SizedBox(height: 24),
                        OrDivider(),
                        SizedBox(height: 24),
                        ElevatedButton(
                          style: defaultElevatedButtonStyle(
                            context: context,
                            backgroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            await locator<GoogleSignIn>().signIn().then((
                              value,
                            ) {
                              if (value != null) {
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
                                      style: TextStyle(
                                        color: const Color(0xFF515151),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 56),
                        TermsOfUseRichText(),
                        SizedBox(height: 36),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
