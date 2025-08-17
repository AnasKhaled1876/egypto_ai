import '../models/check_email/check_email_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/login_response.dart';

part 'auth.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/signup')
  Future<HttpResponse<LoginResponse>> signup({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/login')
  Future<HttpResponse<LoginResponse>> login({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/check-email')
  Future<HttpResponse<CheckEmailResponse>> checkEmail({
    @Query('email') required String email,
  });

  @POST('/google')
  Future<HttpResponse<LoginResponse>> socialSignIn({
    @Body() required Map<String, dynamic> body,
  });
}
