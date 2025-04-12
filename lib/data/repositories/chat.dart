import 'package:egypto_ai/data/base_api_repository.dart';
import 'package:egypto_ai/data/datasources/remote/chat.dart';
import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/repositories/chat.dart';
import 'package:egypto_ai/domain/responses/chat/get_chat.dart';
import 'package:egypto_ai/domain/responses/chat/send_message.dart';

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
  }) {
    return getStateOf<SendMessageResponse>(
      request: () => _chatApiService.sendMessage(body: {"prompt": message}),
    );
  }
}
