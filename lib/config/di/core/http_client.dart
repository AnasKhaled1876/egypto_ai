import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../../core/flavors.dart';

class HttpClientConfig {
  static Future<Dio> configureDio(Flavor flavor) async {
    final storage = GetIt.I<FlutterSecureStorage>();
    final token = await storage.read(key: 'token');

    final baseUrl = switch (flavor) {
      Flavor.development => 'http://10.0.2.2:3000/api/',
      Flavor.production => 'https://egyptoai.site/api/',
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
    )..interceptors.add(AwesomeDioInterceptor());

    return dio;
  }

  static void updateDioBaseUrl(String newBaseUrl) {
    final dio = GetIt.I<Dio>();
    dio.options.baseUrl = newBaseUrl;
  }
}
