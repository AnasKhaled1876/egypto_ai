import 'package:egypto/features/auth/cubit/auth_cubit.dart';
import 'package:egypto/features/countries/cubit/country_cubit.dart';
import 'package:egypto/features/profile/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'features/countries/domain/repositories/country_repository.dart';
import 'features/home/cubit/quick_prompts_cubit.dart';
import 'package:egypto/features/auth/domain/repositories/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:egypto/config/theme/theme.dart';
import 'package:egypto/config/theme/theme_notifier.dart';
import 'package:egypto/features/chat/domain/repositories/chat.dart';
import 'package:egypto/config/di/locator.dart';
import 'package:egypto/features/chat/cubit/chat_cubit.dart';
import 'package:egypto/config/router.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/home/domain/repositories/quick_prompts.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;

    var fem = MediaQuery.sizeOf(context).width / baseWidth;

    var ffem = fem * 0.97;

    textSize = ffem;

    ratio = fem;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(GetIt.I<ProfileRepository>()),
        ),
        BlocProvider<CountryCubit>(
          create: (context) => CountryCubit(GetIt.I<CountryRepository>()),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(GetIt.I<ChatRepository>()),
        ),
        BlocProvider<QuickPromptsCubit>(
          create: (context) =>
              QuickPromptsCubit(GetIt.I<QuickPromptsRepository>()),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(GetIt.I<AuthRepository>()),
        ),
      ],
      child: ValueListenableBuilder<Locale>(
        valueListenable: localeNotifier,
        builder: (BuildContext context, Locale localeValue, Widget? child) =>
            ValueListenableBuilder<ThemeMode>(
              valueListenable: themeNotifier,
              builder:
                  (BuildContext context, ThemeMode themeMode, Widget? child) =>
                      MaterialApp.router(
                        localizationsDelegates:
                            AppLocalizations.localizationsDelegates,
                        locale: localeValue,
                        supportedLocales: AppLocalizations.supportedLocales,
                        debugShowCheckedModeBanner: false,
                        routerConfig: router,
                        darkTheme: buildDarkTheme(fontFamily: 'Outfit'),
                        theme: buildLightTheme(fontFamily: 'Outfit'),
                        themeMode: themeMode,
                      ),
            ),
      ),
    );
  }
}
