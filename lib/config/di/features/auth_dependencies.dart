import 'package:dio/dio.dart';
import 'package:egypto/features/auth/data/repository_impl/auth.dart';
import 'package:get_it/get_it.dart';
import '../../../features/auth/domain/repositories/auth.dart';
import '../../../features/auth/data/datasource/auth.dart';

class AuthDependencies {
  static void register() async {
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
