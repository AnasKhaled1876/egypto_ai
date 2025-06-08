import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/responses/auth/login.dart';
import 'package:egypto_ai/domain/responses/message.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponse>> login({
    required String email,
    required String password,
  });

  Future<DataState<MessageResponse>> checkEmail({required String email});

  Future<DataState<LoginResponse>> signUp({
    required String name,
    required String email,
    required String password,
  });
}
