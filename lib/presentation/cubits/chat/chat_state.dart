part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class SendMessageLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {}

final class SendMessageError extends ChatState {
  final String error;

  SendMessageError({required this.error});
}

final class GetTitleLoadingState extends ChatState {}

final class GetTitleSuccessState extends ChatState {}

final class GetTitleErrorState extends ChatState {
  final String error;

  GetTitleErrorState({required this.error});
}
