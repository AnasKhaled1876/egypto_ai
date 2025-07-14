import 'package:egypto/core/data_state.dart';
import 'package:egypto/features/auth/data/models/login_response.dart';

import '../../../../shared/models/default_response.dart';

abstract class ProfileRepository {
  /// Fetches the current user's profile
  Future<DataState<LoginResponse>> getProfile();

  /// Updates the current user's profile
  Future<DataState<DefaultResponse>> updateProfile({
    String? name,
    String? photoUrl,
    String? fcmToken,
  });
}
