import 'package:egypto/data/base_api_repository.dart';
import 'package:egypto/data/datasources/remote/profile.dart';
import 'package:egypto/core/data_state.dart';
import 'package:egypto/domain/repositories/profile_repository.dart';

import '../../domain/responses/auth/login.dart';
import '../../domain/responses/message.dart';

class ProfileRepositoryImpl extends BaseApiRepository
    implements ProfileRepository {
  final ProfileApiService _profileApiService;

  ProfileRepositoryImpl(this._profileApiService);

  @override
  Future<DataState<LoginResponse>> getProfile() async {
    return getStateOf<LoginResponse>(
      request: () => _profileApiService.getProfile(),
    );
  }

  @override
  Future<DataState<MessageResponse>> updateProfile({
    String? name,
    String? photoUrl,
    String? fcmToken,
  }) async {
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name;
    if (photoUrl != null) body['photoUrl'] = photoUrl;
    if (fcmToken != null) body['fcmToken'] = fcmToken;

    return getStateOf<MessageResponse>(
      request: () => _profileApiService.updateProfile(body),
    );
  }
}
