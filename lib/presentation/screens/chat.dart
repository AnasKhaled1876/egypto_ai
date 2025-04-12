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
  final String senderMessage;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        ChatCubit chatCubit = ChatCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconContainer(
                        icon: SvgPicture.asset("assets/icons/drawer.svg"),
                      ),
                      Text(
                        '${"Greeting"} ${"egypto"}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconContainer(icon: Icon(Icons.more_vert, size: 20)),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: chatCubit.chatMessages.length,
                      itemBuilder:
                          (BuildContext context, int index) => Align(
                            alignment:
                                (chatCubit.chatMessages[index].isUserMessage ??
                                        false)
                                    ? AlignmentDirectional.centerEnd
                                    : AlignmentDirectional.centerStart,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.sizeOf(context).width - 32,
                              ),
                              child: ChatBubble(
                                message:
                                    chatCubit.chatMessages[index].text ?? '',
                                isUserMessage:
                                    chatCubit
                                        .chatMessages[index]
                                        .isUserMessage ??
                                    false,
                              ),
                            ),
                          ),
                      separatorBuilder:
                          (BuildContext context, int index) =>
                              SizedBox(height: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ChatTextField(),
        );
      },
    );
  }
}
