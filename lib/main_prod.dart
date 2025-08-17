import 'package:egypto/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/di/locator.dart';
import 'core/flavors.dart';
import 'shared/services/recorder_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies(flavor: Flavor.production);

  runApp(
    ChangeNotifierProvider(
      create: (context) => VoiceRecordingController(),
      child: const MyApp(),
    ),
  );
}
