// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'create_account_screen.dart';
import 'login_screen.dart';

class MyAuthLayout extends StatelessWidget {
  const MyAuthLayout({super.key});
  final bool login = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double heigth = size.height;
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return KeyboardDismisser(
          gestures: const [
            GestureType.onTap,
            GestureType.onPanUpdateDownDirection
          ],
          child: login == true
              ? LoginScreen(
                  isKeyboardVisible: isKeyboardVisible,
                  width: width,
                  heigth: heigth)
              : CreateAccountScreen(
                  isKeyboardVisible: isKeyboardVisible,
                  width: width,
                  heigth: heigth),
        );
      },
    );
  }
}
