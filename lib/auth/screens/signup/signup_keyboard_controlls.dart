// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/auth/screens/signup/signup_bloc_provider.dart';
import 'package:flutter/material.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignupKeyboardControls extends StatelessWidget {
  const SignupKeyboardControls({
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
        child: SignupBlocProvider(isKeyboardVisible: isKeyboardVisible),
      );
    });
  }
}
