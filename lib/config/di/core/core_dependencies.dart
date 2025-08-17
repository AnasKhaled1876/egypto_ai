import 'dart:io';
import 'dart:ui' show Locale;
import 'package:egypto/config/di/locator.dart';
import 'package:egypto/config/di/utils/firebase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreDependencies {
  static Future<void> register() async {

    // Initialize Firebase
    await FirebaseServices().initialize();

    // Register logger
    GetIt.I.registerLazySingleton<Logger>(() => Logger());

    // Register secure storage
    const storage = FlutterSecureStorage();
    GetIt.I.registerLazySingleton<FlutterSecureStorage>(() => storage);

    // Register shared preferences
    final prefs = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<SharedPreferences>(() => prefs);
    
    
    // Get System Locale If there is no preached locale in SharedPreferences
    final locale = prefs.getString('locale');
    if (locale != null) {
      Intl.defaultLocale = locale;
      localeNotifier.value = Locale(locale);
    }
    // Set default locale which is system locale
    Intl.defaultLocale = Platform.localeName.substring(0,2);
    localeNotifier.value = Locale(Intl.defaultLocale ?? 'ar');
  }
}
