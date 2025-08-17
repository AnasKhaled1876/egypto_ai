
import '../../../../core/data_state.dart';
import '../../data/models/get_countries_response.dart';

abstract class CountryRepository {
  Future<DataState<CountriesResponse>> getCountries({
    int page = 1,
    int limit = 15,
  });
}
