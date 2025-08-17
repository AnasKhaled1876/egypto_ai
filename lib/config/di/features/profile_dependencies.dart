import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/profile/data/repository_impl/profile_repository_impl.dart';
import '../../../features/profile/domain/repositories/profile_repository.dart';
import '../../../features/home/data/datasource/profile.dart';

class ProfileDependencies {
  static void register() {
    GetIt.I.registerLazySingleton<ProfileApiService>(
      () => ProfileApiService(
        GetIt.I<Dio>(),
        baseUrl: '${GetIt.I<Dio>().options.baseUrl}profile',
      ),
    );

    GetIt.I.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(GetIt.I<ProfileApiService>()),
    );
  }
}
