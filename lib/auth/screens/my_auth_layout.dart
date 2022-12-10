// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/auth/screens/login/login_keyboard_controlls.dart';
import 'package:fair_app/auth/screens/signup/signup_keyboard_controlls.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/top_text_widget.dart';
import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

import 'package:grock/grock.dart';

class MyAuthLayout extends StatelessWidget {
  const MyAuthLayout({super.key});

  final String _mainTitle = "Fuar'a Hoşgeldiniz";
  final String _signupText = "Hesap Oluştur";
  final String _signinText = "Giriş Yap";
  final String _cilogluImage = "assets/images/ciloglu.png";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: width - 300 < height ? width * 0.5 : 500,
                  child: Image.asset(_cilogluImage, fit: BoxFit.fill)),
              TopTextWidget(title: _mainTitle),
              verticalSpaceSmall,
              CustomElevatedButton(
                backColor: kcPrimaryCascadeTwilight,
                title: Text(
                  _signupText,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: myButtonFontSize),
                ),
                height: height,
                width: width,
                ontap: () {
                  Grock.to(const SignupKeyboardControls());
                },
              ),
              verticalSpaceTiny,
              CustomOutlinedButton(
                backColor: kcwhite54,
                title: Text(
                  _signinText,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: kcPrimaryCascadeTwilight,
                      fontWeight: FontWeight.bold,
                      fontSize: myButtonFontSize),
                ),
                height: height,
                width: width,
                ontap: () {
                  Grock.to(const LoginKeyboard());
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
