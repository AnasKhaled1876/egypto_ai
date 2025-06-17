import 'dart:io';
import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/entities/models/user.dart';
import 'package:egypto_ai/domain/repositories/auth.dart';
import 'package:egypto_ai/domain/responses/auth/login.dart';
import 'package:egypto_ai/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../domain/responses/auth/check_email_response/check_email_response.dart';
import '../../../utils/helpers/fcm_token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthRepository _authRepository;

  EgyptoUser? user;

  Future<void> checkEmail({required String email}) async {
    emit(CheckEmailLoadingState());
    final result = await _authRepository.checkEmail(email: email);
    if (result is DataSuccess<CheckEmailResponse>) {
      if (result.data?.data?.exists ?? false) {
        emit(EmailExistsState());
      } else {
        emit(EmailNoExistsState());
      }
    } else {
      emit(CheckEmailErrorState(result.error?.message ?? ''));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(LoginLoadingState());

    // Get FCM token with error handling
    final token = await getFcmToken();

    final result = await _authRepository.login(
      email: email,
      password: password,
      fcmToken: token,
      deviceInfo: Platform.isAndroid ? 'Android' : 'IOS',
    );
    if (result is DataSuccess<LoginResponse>) {
      locator<FlutterSecureStorage>().write(
        key: 'token',
        value: result.data?.token,
      );
      user = result.data?.user;
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState(result.error?.message ?? ''));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());

    // Get FCM token with error handling
    final fcmToken = await getFcmToken();

    final result = await _authRepository.signUp(
      name: name,
      email: email,
      password: password,
      fcmToken: fcmToken,
      deviceInfo: Platform.isAndroid ? 'Android' : 'IOS',
    );
    if (result is DataSuccess) {
      locator<FlutterSecureStorage>().write(
        key: 'token',
        value: result.data?.token,
      );

      user = result.data?.user;
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState(result.error?.message ?? ''));
    }
  }

  Future<void> signInWithSocial({
    required String email,
    required String providerId,
    required String name,
    String? photoUrl,
  }) async {
    emit(SocialSignInLoadingState());

    try {
      // Get FCM token with error handling
      final fcmToken = await getFcmToken();

      final result = await _authRepository.socialSignIn(
        email: email,
        providerId: providerId,
        name: name,
        photoUrl: photoUrl,
        fcmToken: fcmToken,
        deviceInfo: Platform.isAndroid ? 'android' : 'ios',
      );

      if (result is DataSuccess) {
        await locator<FlutterSecureStorage>().write(
          key: 'token',
          value: result.data?.token,
        );
        user = result.data?.user;
        emit(SocialSignInSuccessState());
      } else {
        emit(
          SocialSignInErrorState(
            result.error?.message ?? 'Failed to sign in with social account',
          ),
        );
      }
    } catch (e) {
      emit(SocialSignInErrorState('An unexpected error occurred'));
    }
  }
}
