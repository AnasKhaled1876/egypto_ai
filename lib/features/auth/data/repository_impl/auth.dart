import 'package:egypto/core/base_api_repository.dart';
import 'package:egypto/features/auth/data/datasource/auth.dart';
import 'package:egypto/core/data_state.dart';
import 'package:egypto/features/auth/domain/repositories/auth.dart';
import 'package:egypto/features/auth/data/models/login_response.dart';

import '../models/check_email/check_email_response.dart';

class AuthRepositoryImpl extends BaseApiRepository implements AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<LoginResponse>> login({
    required String email,
    required String password,
    String? fcmToken,
    String? deviceInfo,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _authApiService.login(
        body: {
          "email": email,
          "password": password,
          "fcmToken": fcmToken,
          "deviceInfo": deviceInfo,
        },
      ),
    );
  }

  @override
  Future<DataState<LoginResponse>> signUp({
    required String name,
    required String email,
    required String password,
    String? fcmToken,
    String? deviceInfo,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _authApiService.signup(
        body: {
          "name": name,
          "email": email,
          "password": password,
          "fcmToken": fcmToken,
          "deviceInfo": deviceInfo,
        },
      ),
    );
  }

  @override
  Future<DataState<CheckEmailResponse>> checkEmail({required String email}) {
    return getStateOf<CheckEmailResponse>(
      request: () => _authApiService.checkEmail(email: email),
    );
  }

  @override
  Future<DataState<LoginResponse>> socialSignIn({
    required String email,
    required String providerId,
    required String name,
    String? photoUrl,
    String? fcmToken,
    String deviceInfo = 'mobile',
  }) {
    return getStateOf<LoginResponse>(
      request: () => _authApiService.socialSignIn(
        body: {
          'email': email,
          'googleId': providerId,
          'name': name,
          if (photoUrl != null) 'photoUrl': photoUrl,
          if (fcmToken != null) 'fcmToken': fcmToken,
          'deviceInfo': deviceInfo,
        },
      ),
    );
  }
}
