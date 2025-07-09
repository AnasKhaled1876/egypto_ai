import 'package:egypto/config/resources/colors.dart';
import 'package:egypto/l10n/app_localizations.dart';
import 'package:egypto/presentation/cubits/auth/auth_cubit.dart';
import 'package:egypto/presentation/widgets/misc/word_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});
  static const String routeName = 'otp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 28),

        backgroundColor: Colors.transparent,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => context.pop(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28),
            child: BackButtonIcon(),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Hero(
              tag: 'logo',
              child: SvgPicture.asset("assets/icons/logo.svg", height: 22),
            ),
            const Hero(
              tag: 'word-logo',
              child: Material(
                type: MaterialType.transparency,
                child: WordLogo(fontSize: 20),
              ),
            ),
          ],
        ),
        actions: [
          Text(
            AppLocalizations.of(context)!.help,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              decorationColor: Colors.white,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned(
            //   top: 10,
            //   child: SvgPicture.asset("assets/icons/top_ellipse.svg"),
            // ),
            // Positioned(
            //   bottom: -20,
            //   child: SvgPicture.asset("assets/icons/bottom_ellipse.svg"),
            // ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      AppLocalizations.of(context)!.enterTheCode,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),

                    const SizedBox(height: 20),

                    Text.rich(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.weSentCode}\n",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            // * Sent Email
                            text: "${context.read<AuthCubit>().otpMail} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.change,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 65),
                    Material(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                        side: const BorderSide(color: Color(0xFF292929)),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          cursor: Container(
                            height: 32,
                            width: 1.5,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),

                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.all(15),
                            textStyle: Theme.of(
                              context,
                            ).textTheme.headlineLarge,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 56,
                            height: 56,
                            margin: const EdgeInsets.all(15),
                            textStyle: Theme.of(
                              context,
                            ).textTheme.headlineLarge,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
