import 'package:dio/dio.dart';
import 'package:egypto/features/auth/data/repository_impl/auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/auth/domain/repositories/auth.dart';
import '../../../features/auth/data/datasource/auth.dart';


class AuthDependencies {
  static void register() async {
    const scopes = <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ];

    final googleSignIn = GoogleSignIn(
      // clientId: 'your-client_id.apps.googleusercontent.com',
      scopes: scopes,
    );

    GetIt.I.registerLazySingleton<GoogleSignIn>(() => googleSignIn);
    
    GetIt.I.registerLazySingleton<AuthApiService>(
      () => AuthApiService(
        GetIt.I<Dio>(),
        baseUrl: '${GetIt.I<Dio>().options.baseUrl}auth',
      ),
    );

    GetIt.I.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(GetIt.I<AuthApiService>()),
    );
  }
}
