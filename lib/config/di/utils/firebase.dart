import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

import '../../../firebase_options.dart';

/// A service class that handles Firebase initialization and provides access to Firebase services.
class FirebaseServices {
  static final FirebaseServices _instance = FirebaseServices._internal();

  late final FirebaseAnalytics analytics;
  late final FirebaseCrashlytics crashlytics;
  late final FirebaseRemoteConfig remoteConfig;

  factory FirebaseServices() {
    return _instance;
  }

  FirebaseServices._internal();

  /// Initializes all Firebase services.
  ///
  /// Should be called during app startup.
  Future<void> initialize() async {
    try {
      // Initialize Firebase Core
      await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

      // Initialize Crashlytics
      await _initializeCrashlytics();

      // Initialize Remote Config
      await _initializeRemoteConfig();

      // Enable offline persistence for Remote Config
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );

      // Fetch and activate Remote Config
      await _fetchAndActivateRemoteConfig();
    } catch (e, stackTrace) {
      // If initialization fails, log the error to Crashlytics
      if (!kDebugMode) {
        await FirebaseCrashlytics.instance.recordError(e, stackTrace);
      }
      rethrow;
    }
  }

  /// Initializes and configures Firebase Crashlytics.
  Future<void> _initializeCrashlytics() async {
    crashlytics = FirebaseCrashlytics.instance;

    // Enable Crashlytics in non-debug builds
    if (kDebugMode) {
      await crashlytics.setCrashlyticsCollectionEnabled(false);
    } else {
      await crashlytics.setCrashlyticsCollectionEnabled(true);

      // Record any errors that happened before the initialization
      FlutterError.onError = (errorDetails) {
        crashlytics.recordFlutterFatalError(errorDetails);
      };

      // Pass all uncaught asynchronous errors to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        crashlytics.recordError(error, stack, fatal: true);
        return true;
      };
    }
  }

  /// Initializes Firebase Remote Config with default values.
  Future<void> _initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    // Set default Remote Config values
    await remoteConfig.setDefaults(const {
      'welcome_message': 'Welcome to our app!', // Example default value
      'feature_enabled': true, // Example default value
    });
  }

  /// Fetches and activates Remote Config values from the server.
  Future<void> _fetchAndActivateRemoteConfig() async {
    try {
      // Fetch and activate Remote Config
      await remoteConfig.fetchAndActivate();
    } catch (e, stackTrace) {
      // If fetching fails, log the error to Crashlytics
      if (!kDebugMode) {
        await crashlytics.recordError(e, stackTrace);
      }
      // Continue with default values if fetch fails
    }
  }

  /// Records a custom event in Firebase Analytics.
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  /// Records an error in Crashlytics.
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    bool fatal = false,
    Iterable<Object> information = const [],
  }) async {
    if (!kDebugMode) {
      if (fatal) {
        await crashlytics.recordError(
          exception,
          stack,
          reason: reason,
          fatal: true,
          information: information.toList(),
        );
      } else {
        await crashlytics.recordError(
          exception,
          stack,
          reason: reason,
          information: information.toList(),
        );
      }
    }
  }
}
