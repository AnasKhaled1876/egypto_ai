import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              AppLocalizations.of(context)!.hello,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF618B4A),
                fontSize: 23,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.howCanIHelpYou,
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
                QuickPrompts(
                  title: AppLocalizations.of(context)!.study,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.dietPlan,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.sports,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.dDesign,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.dinnerMeal,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.study,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.dietPlan,
                  iconPath: '',
                ),
                QuickPrompts(
                  title: AppLocalizations.of(context)!.sports,
                  iconPath: '',
                ),
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
              // activeIcon: ,
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/planet.svg"),
              label: AppLocalizations.of(context)!.explore,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/icons/chats-circle.svg"),
              label: AppLocalizations.of(context)!.chats,
            ),
          ],
        ),
      ),
    );
  }
}
