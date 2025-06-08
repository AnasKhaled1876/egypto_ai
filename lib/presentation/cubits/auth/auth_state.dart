part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}

final class CheckEmailLoadingState extends AuthState {}

final class CheckEmailSuccessState extends AuthState {}

final class CheckEmailErrorState extends AuthState {
  final String error;

  CheckEmailErrorState(this.error);
}

final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}
