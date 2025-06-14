import 'package:egypto_ai/data/base_api_repository.dart';
import 'package:egypto_ai/data/datasources/remote/auth.dart';
import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/repositories/auth.dart';
import 'package:egypto_ai/domain/responses/auth/login.dart';
import 'package:egypto_ai/domain/responses/message.dart';

class AuthRepositoryImpl extends BaseApiRepository implements AuthRepository {
  final AuthApiService _authApiService;
  AuthRepositoryImpl(this._authApiService);

  @override
  Future<DataState<LoginResponse>> login({
    required String email,
    required String password,
  }) {
    return getStateOf<LoginResponse>(
      request: () =>
          _authApiService.login(body: {"email": email, "password": password}),
    );
  }

  @override
  Future<DataState<LoginResponse>> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return getStateOf<LoginResponse>(
      request: () => _authApiService.signup(
        body: {"name": name, "email": email, "password": password},
      ),
    );
  }

  @override
  Future<DataState<MessageResponse>> checkEmail({required String email}) {
    return getStateOf<MessageResponse>(
      request: () => _authApiService.checkEmail(email: email),
    );
  }
}
