import 'package:egypto/data/base_api_repository.dart';
import 'package:egypto/data/datasources/remote/chat.dart';
import 'package:egypto/data/resources/data_state.dart';
import 'package:egypto/domain/repositories/chat.dart';
import 'package:egypto/domain/responses/chat/get_chat.dart';
import 'package:egypto/domain/responses/chat/send_message.dart';

class ChatRepositoryImpl extends BaseApiRepository implements ChatRepository {
  final ChatApiService _chatApiService;
  ChatRepositoryImpl(this._chatApiService);

  @override
  Future<DataState<GetChatResponse>> getChat() {
    return getStateOf<GetChatResponse>(
      request: () => _chatApiService.getChat(),
    );
  }

  @override
  Future<DataState<SendMessageResponse>> sendMessage({
    required String message,
    required String model,
  }) {
    return getStateOf<SendMessageResponse>(
      request: () => _chatApiService.sendMessage(
        body: {"prompt": message, "model": model},
      ),
    );
  }

  @override
  Future<DataState<SendMessageResponse>> generateTitle({
    required String conversation,
    required String model,
  }) {
    return getStateOf<SendMessageResponse>(
      request: () => _chatApiService.generateTitle(
        body: {"conversation": conversation, "model": model},
      ),
    );
  }
}
