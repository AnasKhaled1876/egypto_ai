import 'package:egypto/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreDependencies {
  static Future<void> register() async {
    // Register Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Register logger
    GetIt.I.registerLazySingleton<Logger>(() => Logger());

    // Register secure storage
    const storage = FlutterSecureStorage();
    GetIt.I.registerLazySingleton<FlutterSecureStorage>(() => storage);

    // Register shared preferences
    final prefs = await SharedPreferences.getInstance();
    GetIt.I.registerLazySingleton<SharedPreferences>(() => prefs);
  }
}
