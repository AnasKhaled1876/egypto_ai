import 'package:egypto/core/data_state.dart';
import 'package:egypto/domain/responses/chat/get_chat.dart';
import 'package:egypto/domain/responses/chat/send_message.dart';

abstract class ChatRepository {
  Future<DataState<GetChatResponse>> getChat();

  Future<DataState<SendMessageResponse>> sendMessage({
    required String message,
    required String model,
  });

  Future<DataState<SendMessageResponse>> generateTitle({
    required String conversation,
    required String model,
  });
}
