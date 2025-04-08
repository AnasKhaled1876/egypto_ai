import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/home/chat_text_field.dart';
import '../widgets/home/quick_prompt.dart';

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
            SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 14,
              runSpacing: 14,
              children: [
                QuickPrompts(title: 'Study', iconPath: ''),
                QuickPrompts(title: 'Diet Plan', iconPath: ''),
                QuickPrompts(title: 'Sports', iconPath: ''),
                QuickPrompts(title: '3D Design', iconPath: ''),
                QuickPrompts(title: 'Dinner Meal', iconPath: ''),
                QuickPrompts(title: 'Study', iconPath: ''),
                QuickPrompts(title: 'Diet Plan', iconPath: ''),
                QuickPrompts(title: 'Sports', iconPath: ''),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
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
      ),
    );
  }
}
