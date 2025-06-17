part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class SendMessageLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {}

class SendMessageError extends ChatState {
  final String error;
  SendMessageError({required this.error});
}

class MessageStreaming extends ChatState {
  final String partialMessage;
  final bool isComplete;

  MessageStreaming({required this.partialMessage, this.isComplete = false});
}

final class GetTitleLoadingState extends ChatState {}

final class GetTitleSuccessState extends ChatState {}

class GetTitleErrorState extends ChatState {
  final String error;
  GetTitleErrorState({required this.error});
}
