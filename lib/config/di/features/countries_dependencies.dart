import 'package:dio/dio.dart';
import 'package:egypto/features/countries/data/datasources/country_api_service.dart';
import 'package:get_it/get_it.dart';
import '../../../features/countries/data/repository_impl/country_repository_impl.dart';
import '../../../features/countries/domain/repositories/country_repository.dart';

class CountryDependencies {
  static void register() async {
    GetIt.I.registerLazySingleton<CountryApiService>(
      () => CountryApiService(
        GetIt.I<Dio>(),
        baseUrl: '${GetIt.I<Dio>().options.baseUrl}countries',
      ),
    );

    GetIt.I.registerLazySingleton<CountryRepository>(
      () => CountryRepositoryImpl(GetIt.I<CountryApiService>()),
    );
  }
}
