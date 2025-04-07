import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/icons/logo.svg",
                  width: 24,
                  height: 24,
                ),
                SizedBox(width: 12),
                SvgPicture.asset("assets/icons/word-logo.svg", height: 35),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22,
                  backgroundImage: AssetImage("assets/images/profile.jpeg"),
                ),
              ],
            ),
            SizedBox(height: 48),
            Text(
              'Hello ! Anas',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF618B4A),
                fontSize: 23,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'How can I help you today ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            ChatTextField(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg"),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/planet.svg"),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/chats-circle.svg"),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _textFieldController = TextEditingController();
  bool _isTyping = false;
  bool _isRecording = false;

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
              decoration: InputDecoration(
                hintText: 'Talk to egypto',
                hintStyle: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(166.67),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                 "assets/icons/microphone.svg",
                width: 20,
                height: 20,
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
