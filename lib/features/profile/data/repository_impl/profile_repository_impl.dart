import 'package:egypto/core/base_api_repository.dart';
import 'package:egypto/features/home/data/datasource/profile.dart';
import 'package:egypto/core/data_state.dart';
import 'package:egypto/features/profile/domain/repositories/profile_repository.dart';

import '../../../auth/data/models/login_response.dart';
import '../../../../shared/models/default_response.dart';

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
  Future<DataState<DefaultResponse>> updateProfile({
    String? name,
    String? photoUrl,
    String? fcmToken,
  }) async {
    final body = <String, dynamic>{};

    if (name != null) body['name'] = name;
    if (photoUrl != null) body['photoUrl'] = photoUrl;
    if (fcmToken != null) body['fcmToken'] = fcmToken;

    return getStateOf<DefaultResponse>(
      request: () => _profileApiService.updateProfile(body),
    );
  }
}
