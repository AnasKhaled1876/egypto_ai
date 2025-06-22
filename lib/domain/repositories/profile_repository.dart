import 'package:egypto/data/resources/data_state.dart';
import 'package:egypto/domain/responses/auth/login.dart';

import '../responses/message.dart';

abstract class ProfileRepository {
  /// Fetches the current user's profile
  Future<DataState<LoginResponse>> getProfile();

  /// Updates the current user's profile
  Future<DataState<MessageResponse>> updateProfile({
    String? name,
    String? photoUrl,
    String? fcmToken,
  });
}
