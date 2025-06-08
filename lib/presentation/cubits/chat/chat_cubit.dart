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
  String? chatTitle;

  void sendMessage(String message) async {
    emit(SendMessageLoading());
    chatMessages.add(Message(text: message, isUserMessage: true));

    final DataState<SendMessageResponse> response = await chatRepository
        .sendMessage(message: message, model: 'gemini');

    if (response is DataSuccess<SendMessageResponse>) {
      chatMessages.add(
        Message(text: response.data?.data, isUserMessage: false),
      );
    } else {
      emit(SendMessageError(error: response.error?.response?.data ?? ''));
      return;
    }

    emit(SendMessageSuccess());
  }

  void getTitle() async {
    emit(GetTitleLoadingState());

    final DataState<SendMessageResponse> response = await chatRepository
        .generateTitle(
          conversation: chatMessages.map((e) => e.text).join(' , '),
          model: 'gemini',
        );

    if (response is DataSuccess<SendMessageResponse>) {
      chatTitle = response.data?.data;
      emit(GetTitleSuccessState());
    } else {
      emit(GetTitleErrorState(error: response.error?.response?.data ?? ''));
      return;
    }
  }
}
