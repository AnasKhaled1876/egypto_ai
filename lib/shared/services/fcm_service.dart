import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

/// A service for handling Firebase Cloud Messaging (FCM) operations.
class FcmService {
  /// Gets the FCM token with proper error handling and permission checks.
  /// Returns null if the token cannot be retrieved.
  Future<String?> getFcmToken() async {
    try {
      final messaging = FirebaseMessaging.instance;

      // Check notification permissions for iOS/macOS
      if (!kIsWeb && (Platform.isIOS || Platform.isMacOS)) {
        final settings = await messaging.getNotificationSettings();

        if (settings.authorizationStatus == AuthorizationStatus.notDetermined) {
          await messaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
        }

        final newSettings = await messaging.getNotificationSettings();
        if (newSettings.authorizationStatus != AuthorizationStatus.authorized &&
            newSettings.authorizationStatus != AuthorizationStatus.provisional) {
          GetIt.I<Logger>().w('User declined or has not accepted permission');
          return null;
        }
      }

      // Get the token
      final token = await messaging.getToken();
      return token;
    } on FirebaseException catch (e) {
      GetIt.I<Logger>().e('Firebase error while getting FCM token: ${e.message}');
      return null;
    } on PlatformException catch (e) {
      GetIt.I<Logger>().e('Platform error while getting FCM token: ${e.message}');
      return null;
    } on Exception catch (e) {
      GetIt.I<Logger>().e('Unexpected error while getting FCM token: $e');
      return null;
    }
  }
}
