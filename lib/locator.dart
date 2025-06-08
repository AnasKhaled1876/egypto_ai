import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:egypto_ai/data/datasources/remote/auth.dart';
import 'package:egypto_ai/data/datasources/remote/chat.dart';
import 'package:egypto_ai/data/repositories/auth.dart';
import 'package:egypto_ai/data/repositories/chat.dart';
import 'package:egypto_ai/domain/entities/enum/flavor.dart';
import 'package:egypto_ai/domain/repositories/auth.dart';
import 'package:egypto_ai/domain/repositories/chat.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

double textSize = 0;
double ratio = 0;

GetIt locator = GetIt.instance;

String languageCode = 'ar';

final ValueNotifier<Locale> localeNotifier = ValueNotifier(Locale('ar'));

// Add a utility method to dynamically update the baseUrl of the Dio instance
void updateDioBaseUrl(String newBaseUrl) {
  final dio = locator<Dio>();
  dio.options.baseUrl = newBaseUrl;
}

Future initializeDependencies({Flavor flavor = Flavor.development}) async {
  const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );

  locator.registerSingleton<GoogleSignIn>(_googleSignIn);

  

  // NotificationHelper notificationHelper = NotificationHelper();

  // locator.registerSingleton<ImageCropperPlatform>(imageCropperPlatform);

  // locator.registerSingleton<NotificationHelper>(notificationHelper);

  // PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // locator.registerSingleton<PackageInfo>(packageInfo);

  // Permission.notification.onGrantedCallback(() {
  //   // locator<NotificationHelper>().showTestNotification();
  // });

  // final remoteConfig = FirebaseRemoteConfig.instance;

  // await remoteConfig.setConfigSettings(
  //   RemoteConfigSettings(
  //     fetchTimeout: const Duration(minutes: 1),
  //     minimumFetchInterval: const Duration(seconds: 50),
  //   ),
  // );

  // await remoteConfig.setDefaults(const {
  //   "add_post_less_steps": true,
  //   "new_categories_screen": true,
  // });

  // await remoteConfig.fetchAndActivate();

  // locator.registerSingleton<FirebaseRemoteConfig>(remoteConfig);

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Intl.defaultLocale = "ar";

  locator.registerSingleton<FirebaseAnalytics>(analytics);

  const storage = FlutterSecureStorage();

  locator.registerSingleton<FlutterSecureStorage>(storage);

  // locator.registerSingleton<ImagePicker>(picker);

  String? token = await locator<FlutterSecureStorage>().read(key: 'token');

  // userCurrentAddress = locator<FlutterSecureStorage>().read(key: 'userAddress');

  final baseUrl = switch (flavor) {
    Flavor.development => 'https://egyptoai-backend.onrender.com/api/',
    Flavor.production => 'https://egyptoai-backend.onrender.com/api/',
    Flavor.staging => 'https://egyptoai-backend.onrender.com/api/',
  };

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        token != null ? 'Authorization' : 'Bearer $token': null,
        // 'Authorization':
        //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwiaWF0IjoxNzMyNDM2NjIyLCJleHAiOjE3MzI1MjMwMjJ9.6R-mEj5GALsCpXjVVM3DKZJbzF15NDzZWyxD4cLoJqc',
      },
    ),
  );

  // precacheImage(const AssetImage('assets/icons/logo.svg'), context);

  dio.interceptors.add(AwesomeDioInterceptor());

  // Modify the Dio instance to allow dynamic baseUrl updates while maintaining the singleton
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<ChatApiService>(ChatApiService(locator<Dio>()));

  locator.registerSingleton<ChatRepository>(
    ChatRepositoryImpl(locator<ChatApiService>()),
  );

  locator.registerSingleton<AuthApiService>(AuthApiService(locator<Dio>()));

  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(locator<AuthApiService>()),
  );
}
