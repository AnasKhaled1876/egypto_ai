import '../../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  const EmailPage({
    required TextEditingController textFieldController, required this.onSubmit, required this.formKey, super.key,
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
            AppLocalizations.of(context)!.yourEmail,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Outfit',
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
            decoration: const InputDecoration(
              hintText: 'name@email.com',
              hintStyle: TextStyle(
                color: Color(0xFF666666),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            style: const TextStyle(
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
