import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/entities/models/user.dart';
import 'package:egypto_ai/domain/repositories/auth.dart';
import 'package:egypto_ai/domain/responses/auth/login.dart';
import 'package:egypto_ai/domain/responses/message.dart';
import 'package:egypto_ai/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthRepository _authRepository;

  EgyptoUser? user;

  Future<void> checkEmail({required String email}) async {
    emit(CheckEmailLoadingState());
    final result = await _authRepository.checkEmail(email: email);
    if (result is DataSuccess<MessageResponse>) {
      
      emit(CheckEmailSuccessState());
    } else {
      emit(CheckEmailErrorState(result.error?.message ?? ''));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(LoginLoadingState());
    final result = await _authRepository.login(
      email: email,
      password: password,
    );
    if (result is DataSuccess<LoginResponse>) {
      locator<FlutterSecureStorage>().write(
        key: 'token',
        value: result.data?.token,
      );
      locator<FlutterSecureStorage>().write(key: 'email', value: email);
      locator<FlutterSecureStorage>().write(key: 'password', value: password);
      user = result.data?.user;
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState(result.error?.message ?? ''));
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoadingState());
    final result = await _authRepository.signUp(
      name: name,
      email: email,
      password: password,
    );
    if (result is DataSuccess) {
      locator<FlutterSecureStorage>().write(
        key: 'token',
        value: result.data?.token,
      );
      locator<FlutterSecureStorage>().write(key: 'email', value: email);
      locator<FlutterSecureStorage>().write(key: 'password', value: password);
      user = result.data?.user;
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState(result.error?.message ?? ''));
    }
  }
}
