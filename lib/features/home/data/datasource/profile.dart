import '../../../auth/data/models/login_response.dart';
import '../../../../shared/models/default_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'profile.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET('')
  Future<HttpResponse<LoginResponse>> getProfile();

  @PUT('')
  Future<HttpResponse<DefaultResponse>> updateProfile(
    @Body() Map<String, dynamic> body,
  );
}
