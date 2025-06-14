import 'package:egypto_ai/domain/responses/auth/login.dart';
import 'package:egypto_ai/domain/responses/message.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @GET('/login')
  Future<HttpResponse<LoginResponse>> signup({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/signup')
  Future<HttpResponse<LoginResponse>> login({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/check-email')
  Future<HttpResponse<MessageResponse>> checkEmail({
    @Query('email') required String email,
  });
}
