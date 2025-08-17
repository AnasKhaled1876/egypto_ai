import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/get_countries_response.dart';

part 'country_api_service.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class CountryApiService {
  factory CountryApiService(Dio dio, {String baseUrl}) = _CountryApiService;

  @GET('')
  Future<HttpResponse<CountriesResponse>> getCountries({
    @Query('page') int page = 1,
    @Query('limit') int limit = 15,
  });
}
