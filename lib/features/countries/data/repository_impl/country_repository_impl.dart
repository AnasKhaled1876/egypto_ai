import 'package:egypto/features/countries/data/models/get_countries_response.dart';

import '../../../../core/base_api_repository.dart';
import '../../../../core/data_state.dart';
import '../../domain/repositories/country_repository.dart';
import '../datasources/country_api_service.dart';

class CountryRepositoryImpl extends BaseApiRepository
    implements CountryRepository {
  final CountryApiService _countryApiService;

  CountryRepositoryImpl(this._countryApiService);

  @override
  Future<DataState<CountriesResponse>> getCountries({
    int page = 1,
    int limit = 15,
  }) async {
    return getStateOf<CountriesResponse>(
      request: () => _countryApiService.getCountries(page: page, limit: limit),
    );
  }
}
