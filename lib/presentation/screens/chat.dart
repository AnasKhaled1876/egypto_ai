import 'package:egypto_ai/presentation/cubits/chat/chat_cubit.dart';
import 'package:egypto_ai/presentation/widgets/home/chat_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat/chat_bubble.dart';
import '../widgets/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.senderMessage});
  static const routeName = 'chat';
  final String? senderMessage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.senderMessage?.isNotEmpty ?? false) {
      ChatCubit.get(context).sendMessage(widget.senderMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // Handle error states
        if (state is SendMessageError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
        }
      },
      builder: (context, state) {
        ChatCubit chatCubit = ChatCubit.get(context);

        // Determine if we're currently streaming
        final bool isStreaming =
            state is MessageStreaming && !(state).isComplete;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    spacing: 24,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconContainer(
                        icon: SvgPicture.asset(
                          "assets/icons/drawer.svg",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      state is GetTitleLoadingState
                          ? CircularProgressIndicator.adaptive()
                          : Expanded(
                              child: Text(
                                chatCubit.chatTitle ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                      IconContainer(icon: Icon(Icons.more_vert, size: 20)),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: chatCubit.chatMessages.length,
                            itemBuilder: (BuildContext context, int index) {
                              final isFirstMessage =
                                  index == 0 &&
                                  chatCubit.chatMessages.length == 1;
                              final isUserMessage =
                                  chatCubit.chatMessages[index].isUserMessage ??
                                  false;
                              final message =
                                  chatCubit.chatMessages[index].text ?? '';

                              // Check if this is the last message and it's currently streaming
                              final bool isStreamingThisMessage =
                                  !isUserMessage &&
                                  index == chatCubit.chatMessages.length - 1 &&
                                  isStreaming;

                              Widget messageWidget = ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.sizeOf(context).width - 32,
                                ),
                                child: ChatBubble(
                                  message: message,
                                  isLoading:
                                      isStreamingThisMessage ||
                                      message.isEmpty ||
                                      state is SendMessageLoading,
                                  isUserMessage: isUserMessage,
                                  isTyping: isStreamingThisMessage,
                                ),
                              );

                              // Apply hero animation only to the first message
                              if (isFirstMessage) {
                                messageWidget = Hero(
                                  tag: 'chat_message_hero',
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: messageWidget,
                                  ),
                                );
                              }

                              return Align(
                                alignment: isUserMessage
                                    ? AlignmentDirectional.centerEnd
                                    : AlignmentDirectional.centerStart,
                                child: messageWidget,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ChatTextField(fromHome: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
