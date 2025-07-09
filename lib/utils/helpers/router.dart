import 'package:egypto/presentation/screens/chat.dart';
import 'package:egypto/presentation/screens/home.dart';
import 'package:egypto/presentation/screens/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/cubits/quick_prompts/quick_prompts_cubit.dart';
import '../../presentation/screens/auth/register/otp.dart';
import '../../presentation/screens/auth/register/register.dart';
import '../../presentation/screens/start/start.dart';
import '../../presentation/screens/start/welcome.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) => SplashScreen(),
      routes: [
        GoRoute(
          path: WelcomeScreen.routeName,
          name: WelcomeScreen.routeName,
          builder: (context, state) => WelcomeScreen(),
        ),
        GoRoute(
          path: StartScreen.routeName,
          name: StartScreen.routeName,
          builder: (context, state) => StartScreen(),
        ),
        GoRoute(
          path: OTPScreen.routeName,
          name: OTPScreen.routeName,
          builder: (context, state) => OTPScreen(),
        ),
        GoRoute(
          path: RegisterScreen.routeName,
          name: RegisterScreen.routeName,
          builder: (context, state) => RegisterScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          name: HomeScreen.routeName,
          builder: (context, state) {
            context.read<QuickPromptsCubit>().getQuickPrompts();
            return HomeScreen();
          },
        ),
        GoRoute(
          path: ChatScreen.routeName,
          name: ChatScreen.routeName,
          builder: (context, state) {
            final String? senderMessage = state.extra as String?;
            return ChatScreen(senderMessage: senderMessage);
          },
        ),
      ],
    ),
  ],
);
