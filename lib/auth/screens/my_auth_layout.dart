// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/auth/screens/login/keyboard_controlls.dart';
import 'package:fair_app/auth/shared/beautification.dart';
import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:fair_app/auth/widgets/top_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'signup/signup_screen.dart';
import 'package:get/get.dart';

class MyAuthLayout extends StatelessWidget {
  const MyAuthLayout({super.key});
  final bool login = true;
  final String _mainTitle = "Fuar'a Hoşgeldiniz";

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
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                  child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: width * 0.5,
                        child: Image.asset("assets/images/ciloglu.png",
                            fit: BoxFit.fill)),
                    TopTextWidget(title: _mainTitle),
                    verticalSpaceSmall,
                    ElevatedButton(
                      onPressed: () {
                        Get.to(CreateAccountScreen(
                            isKeyboardVisible: isKeyboardVisible,
                            width: width,
                            heigth: heigth));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kcPrimaryCascadeTwilight,
                        fixedSize: Size.fromWidth(width * 0.9),
                      ),
                      child: const Text("Hesap Oluştur"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Get.to((const KeyboardControls()));
                      },
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size.fromWidth(width * 0.9)),
                      child: const Text("Oturum Aç"),
                    )
                  ],
                ),
              )),
            ));
      },
    );
  }
}
