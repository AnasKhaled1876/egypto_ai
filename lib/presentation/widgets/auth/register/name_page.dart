import '../../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NamePage extends StatelessWidget {
  const NamePage({
    super.key,
    required TextEditingController textFieldController,
    required this.onSubmit,
    required this.formKey,
  }) : _textFieldController = textFieldController;

  final TextEditingController _textFieldController;
  final void Function(String value) onSubmit;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.yourName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.pleaseEnterYourName;
              }
              return null;
            },
            onFieldSubmitted: onSubmit,
            controller: _textFieldController,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.talkToEgypto,
              hintStyle: TextStyle(
                color: const Color(0xFF666666),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
