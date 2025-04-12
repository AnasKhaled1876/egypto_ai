import 'package:egypto_ai/presentation/cubits/chat/chat_cubit.dart';
import 'package:egypto_ai/presentation/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _isTyping = false;
  // bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      setState(() {
        _isTyping = _textFieldController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is SendMessageSuccess) {
          setState(() {
            _isTyping = false;
          });
          context.pushNamed(
            ChatScreen.routeName,
            extra: _textFieldController.text,
          );
          _textFieldController.clear();
        }
        if (state is SendMessageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error sending message'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        ChatCubit chatCubit = ChatCubit.get(context);
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFF0F0F0F),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.50, color: const Color(0xFF618B4A)),
              borderRadius: BorderRadius.circular(200),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  color: const Color(0xFF191919),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(166.67),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
              SizedBox(width: 28),
              Expanded(
                child: TextField(
                  controller: _textFieldController,
                  onEditingComplete: () {
                    if (_isTyping) {
                      chatCubit.sendMessage(_textFieldController.text);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.talkToEgypto,
                    hintStyle: TextStyle(
                      color: const Color(0xFF666666),
                      fontSize: 18,
                      fontFamily: 'SomarSans',
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'SomarSans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_isTyping) {
                    chatCubit.sendMessage(_textFieldController.text);
                  }
                },
                child: AnimatedContainer(
                  width: 40,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: _isTyping ? Color(0xFF618B4A) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(166.67),
                    ),
                  ),
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 100),
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                    ) {
                      return ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child:
                        state is SendMessageLoading
                            ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircularProgressIndicator.adaptive(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                            : _isTyping
                            ? Center(
                              child: SvgPicture.asset(
                                "assets/icons/arrow-up.svg",
                                width: 20,
                                height: 20,
                              ),
                            )
                            : Center(
                              child: SvgPicture.asset(
                                "assets/icons/microphone.svg",
                                width: 20,
                                height: 20,
                              ),
                            ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }
}
