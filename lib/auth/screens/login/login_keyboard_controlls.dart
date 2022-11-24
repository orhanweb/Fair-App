// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:fair_app/auth/screens/login/login_bloc_provider.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginKeyboard extends StatelessWidget {
  const LoginKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return KeyboardDismisser(
        gestures: const [
          GestureType.onTap,
          GestureType.onPanUpdateDownDirection
        ],
        child: LoginBlocPattern(isKeyboardVisible: isKeyboardVisible),
      );
    });
  }
}
