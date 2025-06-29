import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egypto_ai/config/theme/dark.dart';
import 'package:egypto_ai/domain/entities/enum/flavor.dart';
import 'package:egypto_ai/domain/repositories/auth.dart';
import 'package:egypto_ai/domain/repositories/chat.dart';
import 'package:egypto_ai/locator.dart';
import 'package:egypto_ai/presentation/cubits/auth/auth_cubit.dart';
import 'package:egypto_ai/presentation/cubits/chat/chat_cubit.dart';
import 'package:egypto_ai/utils/helpers/router.dart';
import 'domain/repositories/quick_prompts.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'presentation/cubits/quick_prompts/quick_prompts_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initializeDependencies(flavor: Flavor.development);

  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;

    double fem = MediaQuery.sizeOf(context).width / baseWidth;

    double ffem = fem * 0.97;

    textSize = ffem;

    ratio = fem;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(locator<AuthRepository>()),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(locator<ChatRepository>()),
        ),
        BlocProvider<QuickPromptsCubit>(
          create: (context) =>
              QuickPromptsCubit(locator<QuickPromptsRepository>()),
        ),
      ],
      child: ValueListenableBuilder<Locale>(
        valueListenable: localeNotifier,
        builder: (BuildContext context, Locale value, Widget? child) =>
            MaterialApp.router(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: value,
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              theme: darkTheme,
              themeMode: ThemeMode.dark,
            ),
      ),
    );
  }
}
