import 'package:egypto_ai/data/resources/data_state.dart';
import 'package:egypto_ai/domain/entities/models/message.dart';
import 'package:egypto_ai/domain/repositories/chat.dart';
import 'package:egypto_ai/domain/responses/chat/send_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepository) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRepository chatRepository;

  List<Message> chatMessages = [];
  String? botMessage;

  void sendMessage(String message) async {
    emit(SendMessageLoading());
    chatMessages.add(Message(text: message, isUserMessage: true));

    final DataState<SendMessageResponse> response = await chatRepository
        .sendMessage(message: message);

    if (response is DataSuccess<SendMessageResponse>) {
      chatMessages.add(
        Message(text: response.data?.data, isUserMessage: false),
      );
    } else {
      emit(SendMessageError());
      return;
    }

    emit(SendMessageSuccess());
  }
}
