import 'dart:async';

import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final String title;
  final String subTitle;
  final String mainButtonTitle;
  final Widget form;
  final bool showTermsText;
  final Function onTapMainButton;
  final Function onCreateAccountTapped;
  final Function forgotPassword;
  final void Function()? onbackPressed;
  final String validationMessage;
  final bool busy;

  const LoginPage(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.mainButtonTitle,
      required this.form,
      required this.showTermsText,
      required this.onTapMainButton,
      required this.onCreateAccountTapped,
      required this.forgotPassword,
      required this.onbackPressed,
      required this.validationMessage,
      required this.busy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(children: [
        onbackPressed == null
            ? verticalSpaceLarge
            : Row(
                children: [
                  verticalSpaceRegular,
                  IconButton(
                      onPressed: onbackPressed,
                      icon: const Icon(Icons.arrow_back_ios_new_rounded))
                ],
              ),
      ]),
    );
  }
}
