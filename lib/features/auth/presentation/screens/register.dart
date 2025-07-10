import 'package:egypto/config/di/locator.dart';
import 'package:egypto/features/profile/cubit/profile_cubit.dart';
import 'package:egypto/features/start/presentation/screens/splash.dart';
import 'package:egypto/features/auth/presentation/widgets/password_page.dart';
import 'package:egypto/shared/widgets/buttons/bubble_button.dart';
import 'package:egypto/shared/widgets/icons/icon_container.dart';
import 'package:egypto/shared/widgets/indicators/linear_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/email_page.dart';
import '../widgets/name_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PageController _pageController = PageController(initialPage: 0);

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 44,

        leadingWidth: 52,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: IconContainer(
            onTap: () {
              if (_currentPage == 1) {
                context.goNamed(SplashScreen.routeName);
              } else if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else if (_currentPage == 0) {
                context.pop();
              }
            },
            icon: Transform.flip(
              flipX: localeNotifier.value.languageCode == "ar",
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.profileSetup,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 32),
              LinearProgressBar(
                progress: switch (_currentPage) {
                  0 => 0.25,
                  1 => 0.5,
                  2 => 0.75,
                  int() => 0,
                },
                width: MediaQuery.of(context).size.width - 50,
                borderRadius: 8,
                height: 4,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                progressColor: Colors.white,
              ),
              const SizedBox(height: 54),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NamePage(
                      formKey: _nameFormKey,
                      textFieldController: _nameController,
                      onSubmit: (String value) {
                        if (_nameFormKey.currentState?.validate() ?? false) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                    EmailPage(
                      textFieldController: _emailController,
                      onSubmit: (String value) {
                        if (_emailFormKey.currentState?.validate() ?? false) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      formKey: _emailFormKey,
                    ),
                    PasswordPage(
                      textFieldController: _passwordController,
                      onSubmit: (String value) {
                        if (_passwordFormKey.currentState?.validate() ??
                            false) {
                          AuthCubit.get(context).signUp(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      formKey: _passwordFormKey,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    ProfileCubit.get(context).getProfile();
                  }
                },
                builder: (context, state) {
                  return BubbleButton(
                    title: AppLocalizations.of(context)!.continueRegister,
                    onTap: () {
                      switch (_currentPage) {
                        case 0:
                          if (_nameFormKey.currentState?.validate() ?? false) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                          break;
                        case 1:
                          if (_emailFormKey.currentState?.validate() ?? false) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                          break;
                        case 2:
                          if (_passwordFormKey.currentState?.validate() ??
                              false) {
                            AuthCubit.get(context).signUp(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                          break;
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
