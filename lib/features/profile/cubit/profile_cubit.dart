import 'package:egypto/domain/repositories/profile_repository.dart';
import 'package:egypto/domain/responses/auth/login.dart';
import 'package:egypto/core/data_state.dart';
import 'package:egypto/domain/responses/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getProfile() async {
    try {
      emit(ProfileLoading());
      final result = await _profileRepository.getProfile();

      if (result is DataSuccess<LoginResponse>) {
        result;
        emit(ProfileLoaded());
      } else {
        emit(ProfileError(errorMessage(result.error!)));
      }
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> updateProfile({
    String? name,
    String? photoUrl,
    String? fcmToken,
  }) async {
    try {
      emit(ProfileLoading());
      final result = await _profileRepository.updateProfile(
        name: name,
        photoUrl: photoUrl,
        fcmToken: fcmToken,
      );

      if (result is DataSuccess<MessageResponse>) {
        result;
        emit(ProfileUpdateSuccess());
      } else {
        emit(ProfileError(errorMessage(result.error!)));
      }
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
    }
  }
}
