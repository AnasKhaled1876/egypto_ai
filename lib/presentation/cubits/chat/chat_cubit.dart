import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:egypto/data/resources/data_state.dart';
import 'package:egypto/domain/entities/models/message.dart';
import 'package:egypto/domain/repositories/chat.dart';
import 'package:egypto/domain/responses/chat/send_message.dart';
import 'package:egypto/locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepository) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final ChatRepository chatRepository;

  List<Message> chatMessages = [];
  String? botMessage;
  String? chatTitle;
  final Logger _logger = Logger();
  String _currentStreamingMessage = '';

  Future<void> sendMessage(String message) async {
    try {
      // Update UI for loading and add user message
      emit(SendMessageLoading());
      chatMessages.add(Message(text: message, isUserMessage: true));

      // Add an empty bot message that we'll update with the streaming response
      chatMessages.add(Message(text: '', isUserMessage: false));
      _currentStreamingMessage = '';

      // Make the request with streaming enabled
      final response = await locator.get<Dio>().post(
        '/chat',
        data: {'prompt': message, 'model': 'deepseek'},
        options: Options(responseType: ResponseType.stream),
      );

      // Handle the response stream
      if (response.statusCode == 200) {
        final responseStream = response.data as ResponseBody;
        final stream = responseStream.stream;

        // Process the stream
        await for (var chunk in stream) {
          // Convert chunk to string
          final chunkStr = utf8.decode(chunk);

          // Process each line in the chunk
          final lines = chunkStr.split('\n');
          for (var line in lines) {
            line = line;
            // Handle the line - support both SSE format and raw text
            if (line.startsWith('data: ')) {
              final data = line.substring(6);
              if (data == '[DONE]') {
                // Emit final streaming state with completion flag
                emit(
                  MessageStreaming(
                    partialMessage: _currentStreamingMessage,
                    isComplete: true,
                  ),
                );
                // Then emit success state to indicate completion
                emit(SendMessageSuccess());
                _currentStreamingMessage = '';
                return;
              }

              try {
                // First try to parse as JSON
                try {
                  final jsonData = jsonDecode(data);
                  if (jsonData is Map) {
                    final text =
                        jsonData['choices']?[0]?['delta']?['content'] ?? '';
                    if (text.isNotEmpty) {
                      _currentStreamingMessage += text;
                      _updateLastMessage(_currentStreamingMessage);
                      emit(
                        MessageStreaming(
                          partialMessage: _currentStreamingMessage,
                        ),
                      );
                    }
                    return;
                  }
                } catch (_) {
                  // If JSON parsing fails, treat as raw text
                }

                // If we get here, treat the data as raw text
                if (data.isNotEmpty) {
                  _currentStreamingMessage += data;
                  _updateLastMessage(_currentStreamingMessage);
                  emit(
                    MessageStreaming(partialMessage: _currentStreamingMessage),
                  );
                }
              } catch (e) {
                _logger.e('Error processing chunk: $e');
                _logger.e('Problematic data: $data');
              }
            }
          }
        }
        // Ensure we emit success state even if no DONE marker is received
        emit(SendMessageSuccess());
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      _logger.e('Error in sendMessage: $e');
      emit(SendMessageError(error: e.toString()));
    }
  }

  void _updateLastMessage(String text) {
    if (chatMessages.isNotEmpty) {
      final lastIndex = chatMessages.length - 1;
      chatMessages[lastIndex] = chatMessages[lastIndex].copyWith(text: text);
    }
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
