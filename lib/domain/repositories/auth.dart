import 'package:egypto/data/resources/data_state.dart';
import 'package:egypto/domain/responses/auth/login.dart';
import '../responses/auth/check_email_response/check_email_response.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponse>> login({
    required String email,
    required String password,
    String? fcmToken,
    String? deviceInfo,
  });

  Future<DataState<LoginResponse>> socialSignIn({
    required String email,
    required String providerId,
    required String name,
    String? photoUrl,
    String? fcmToken,
    String deviceInfo = 'mobile',
  });

  Future<DataState<CheckEmailResponse>> checkEmail({required String email});

  Future<DataState<LoginResponse>> signUp({
    required String name,
    required String email,
    required String password,
    String? fcmToken,
    String? deviceInfo,
  });
}
