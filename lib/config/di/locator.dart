import 'package:dio/dio.dart';
import 'package:egypto/shared/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// Core Dependencies
import '../../core/flavors.dart';
import 'core/core_dependencies.dart';
import 'core/http_client.dart';

// Feature Dependencies
import 'features/auth_dependencies.dart';
import 'features/chat_dependencies.dart';
import 'features/countries_dependencies.dart';
import 'features/profile_dependencies.dart';
import 'features/quick_prompts_dependencies.dart';

/// Global variables
double textSize = 0;
double ratio = 0;
String languageCode = 'ar';

/// Localization
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

/// Updates the base URL for the Dio HTTP client.
///
/// [newBaseUrl] The new base URL to be set for API requests.
void updateDioBaseUrl(String newBaseUrl) {
  HttpClientConfig.updateDioBaseUrl(newBaseUrl);
}

/// Initializes all application dependencies
///
/// [flavor] The app flavor to determine the base URL and other configurations.
Future<void> initializeDependencies({
  Flavor flavor = Flavor.development,
}) async {
  // Register core dependencies
  await CoreDependencies.register();

  // Configure and register HTTP client
  final dio = await HttpClientConfig.configureDio(flavor);
  GetIt.I.registerLazySingleton<Dio>(() => dio);

  // Register FCM service
  GetIt.I.registerLazySingleton<FcmService>(() => FcmService());

  // Register feature-specific dependencies
  AuthDependencies.register();
  ChatDependencies.register();
  ProfileDependencies.register();
  QuickPromptsDependencies.register();
  CountryDependencies.register();
}
