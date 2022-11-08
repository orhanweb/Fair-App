import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:fair_app/auth/widgets/bottom_text.dart';
import 'package:fair_app/auth/widgets/custom_button.dart';
import 'package:fair_app/auth/widgets/custom_input_field.dart';
import 'package:fair_app/auth/widgets/top_text_widget.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen(
      {Key? key,
      required this.isKeyboardVisible,
      required this.width,
      required this.heigth})
      : super(key: key);

  final bool isKeyboardVisible;
  final double width;
  final double heigth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
        isKeyboardVisible
            ? Container()
            : TopTextWidget(
                width: width, heigth: heigth, title: "Create\nAccount"),
        Padding(
          padding: EdgeInsets.only(
              top: isKeyboardVisible ? heigth * 0.20 : heigth * 0.35),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomInputField(
                width: width,
                hint: "Name",
                prevIcon: const Icon(Icons.person),
              ),
              verticalSpaceTiny,
              CustomInputField(
                  prevIcon: const Icon(Icons.mail),
                  width: width,
                  hint: "Email"),
              verticalSpaceTiny,
              CustomInputField(
                  prevIcon: const Icon(Icons.lock_rounded),
                  width: width,
                  hint: "PassWord",
                  passwordfeatures: true),
            ],
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: heigth * 0.4),
              child: const CustomLoginButton(title: "Sign up"),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: heigth * 0.05),
            child: BottomText(
                width: width,
                heigth: heigth,
                title: "Already have an account?",
                buttonTitle: "Sign in"),
          ),
        ),
      ])),
    );
  }
}
