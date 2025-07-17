import 'package:cached_network_image/cached_network_image.dart';
import 'package:egypto/features/auth/cubit/auth_cubit.dart';
import 'package:egypto/shared/widgets/word_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/services/fcm_service.dart';
import '../../cubit/quick_prompts_cubit.dart';
import '../widgets/chat_text_field.dart';
import '../widgets/quick_prompt.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    showNotification();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF0F0F0F),
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const WordLogo(),
                if (context.read<AuthCubit>().user?.photoUrl != null) ...[
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22,
                    backgroundImage: CachedNetworkImageProvider(
                      context.read<AuthCubit>().user?.photoUrl ?? '',
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 48),
            Text(
              AppLocalizations.of(context)!.hello,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.howCanIHelpYou,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            const ChatTextField(fromHome: true),
            const SizedBox(height: 40),
            BlocBuilder<QuickPromptsCubit, QuickPromptsState>(
              builder: (context, state) {
                if (state is QuickPromptsSuccess) {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 14,
                    runSpacing: 14,
                    children: context
                        .watch<QuickPromptsCubit>()
                        .quickPrompts
                        .map((e) => QuickPrompts(title: e.text, emoji: e.emoji))
                        .toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
