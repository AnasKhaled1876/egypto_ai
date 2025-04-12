import 'package:egypto_ai/presentation/screens/chat.dart';
import 'package:egypto_ai/presentation/screens/home.dart';
import 'package:egypto_ai/presentation/screens/get_started.dart';
import 'package:egypto_ai/presentation/screens/splash.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) => SplashScreen(),
      routes: [
        GoRoute(
          path: GetStartedScreen.routeName,
          name: GetStartedScreen.routeName,
          builder: (context, state) => GetStartedScreen(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          name: HomeScreen.routeName,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: ChatScreen.routeName,
          name: ChatScreen.routeName,
          builder: (context, state) {
            final String senderMessage = state.extra as String;
            return ChatScreen(senderMessage: senderMessage);
          },
        ),
      ],
    ),
  ],
);
