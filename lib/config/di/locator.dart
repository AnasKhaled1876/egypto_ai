import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:egypto/data/datasources/remote/auth.dart';
import 'package:egypto/data/datasources/remote/chat.dart';
import 'package:egypto/data/datasources/remote/profile.dart';
import 'package:egypto/data/repositories/auth.dart';
import 'package:egypto/data/repositories/chat.dart';
import 'package:egypto/domain/entities/enum/flavor.dart';
import 'package:egypto/domain/repositories/auth.dart';
import 'package:egypto/domain/repositories/chat.dart';
import 'package:egypto/shared/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/remote/quick_prompts.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/repositories/quick_prompts.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/quick_prompts.dart';

double textSize = 0;
double ratio = 0;

GetIt locator = GetIt.instance;

String languageCode = 'ar';

final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('ar'));

// Add a utility method to dynamically update the baseUrl of the Dio instance
void updateDioBaseUrl(String newBaseUrl) {
  final dio = locator<Dio>();
  dio.options.baseUrl = newBaseUrl;
}

Future initializeDependencies({Flavor flavor = Flavor.development}) async {
  const scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  var googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );

  locator.registerSingleton<GoogleSignIn>(googleSignIn);

  locator.registerSingleton<Logger>(Logger());

  locator.registerSingleton<FcmService>(FcmService());


  Intl.defaultLocale = "ar";


  const storage = FlutterSecureStorage();

  locator.registerSingleton<FlutterSecureStorage>(storage);

  final prefs = await SharedPreferences.getInstance();

  locator.registerSingleton<SharedPreferences>(prefs);

  var token = await locator<FlutterSecureStorage>().read(key: 'token');

  final baseUrl = switch (flavor) {
    Flavor.development => 'https://egypto-ai-backend.onrender.com/api/',
    Flavor.production => 'https://egypto-ai-backend.onrender.com/api/',
    Flavor.staging => 'https://egypto-ai-backend.onrender.com/api/',
  };

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    ),
  );

  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<ChatApiService>(
    ChatApiService(locator<Dio>(), baseUrl: '${baseUrl}chat'),
  );

  locator.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(locator<ChatApiService>()),
  );

  locator.registerSingleton<AuthApiService>(
    AuthApiService(locator<Dio>(), baseUrl: '${baseUrl}auth'),
  );

  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(locator<AuthApiService>()),
  );

  locator.registerSingleton<QuickPromptsApiService>(
    QuickPromptsApiService(locator<Dio>(), baseUrl: '${baseUrl}quick-prompts'),
  );

  locator.registerSingleton<QuickPromptsRepository>(
    QuickPromptsRepositoryImpl(locator<QuickPromptsApiService>()),
  );

  locator.registerSingleton<ProfileApiService>(
    ProfileApiService(locator<Dio>(), baseUrl: '${baseUrl}profile'),
  );

  locator.registerSingleton<ProfileRepository>(
    ProfileRepositoryImpl(locator<ProfileApiService>()),
  );
}
