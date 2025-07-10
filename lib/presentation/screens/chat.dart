import 'package:egypto/l10n/app_localizations.dart';
import 'package:egypto/locator.dart';
import 'package:egypto/presentation/cubits/chat/chat_cubit.dart';
import 'package:egypto/presentation/widgets/home/chat_text_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat/chat_bubble.dart';
import '../../core/shared/icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.senderMessage, super.key});
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
        var chatCubit = ChatCubit.get(context);

        // Determine if we're currently streaming
        final isStreaming =
            state is MessageStreaming && !(state).isComplete;

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
          body: AdvancedDrawer(
            backdropColor: Colors.transparent,
            openRatio: 0.8,
            openScale: 0.95,
            rtlOpening: localeNotifier.value.languageCode == 'ar',
            drawer: SafeArea(
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF1D1D1D)),
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.search,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 6,
                            ),
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  const Color(0xFF4E7F62),
                                  const Color(0xFF20639B),
                                  const Color(0xFF1C2895),
                                ],
                                stops: const [0.0, 0.32, 0.74, 1.0],
                                begin: const AlignmentDirectional(-0.7, 3.5),
                                end: const AlignmentDirectional(0.7, -3.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2000),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 8,
                              children: [
                                const Icon(Icons.add, color: Colors.white, size: 18),
                                Text(
                                  AppLocalizations.of(context)!.newChat,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(ratio * 24),
                ),
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
                            ? const CircularProgressIndicator.adaptive()
                            : Expanded(
                                child: Text(
                                  chatCubit.chatTitle ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                        const IconContainer(icon: Icon(Icons.more_vert, size: 20)),
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
                                    chatCubit
                                        .chatMessages[index]
                                        .isUserMessage ??
                                    false;
                                final message =
                                    chatCubit.chatMessages[index].text ?? '';

                                // Check if this is the last message and it's currently streaming
                                final isStreamingThisMessage =
                                    !isUserMessage &&
                                    index ==
                                        chatCubit.chatMessages.length - 1 &&
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
                    const ChatTextField(fromHome: false),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
