import '../../../../domain/responses/auth/login.dart';
import '../../../../domain/responses/message.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'profile.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ProfileApiService {
  factory ProfileApiService(Dio dio, {String baseUrl}) = _ProfileApiService;

  @GET('')
  Future<HttpResponse<LoginResponse>> getProfile();

  @PUT('')
  Future<HttpResponse<MessageResponse>> updateProfile(
    @Body() Map<String, dynamic> body,
  );
}
