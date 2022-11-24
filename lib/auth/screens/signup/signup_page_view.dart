import 'package:flutter/material.dart';

import 'package:fair_app/auth/widgets/back_button.dart';
import 'package:fair_app/auth/widgets/top_text_widget.dart';

import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/shared/beautification.dart';
import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:fair_app/auth/widgets/custom_button.dart';
import 'package:fair_app/auth/widgets/custom_input_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPageView extends StatelessWidget {
  final BuildContext context;
  final dynamic state;
  final bool isKeyboardVisible;

  const SignupPageView({
    Key? key,
    required this.isKeyboardVisible,
    required this.context,
    required this.state,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
        const BackButtonWidget(),
        topText(height: height),
        LoginContent(
            isKeyboardVisible: isKeyboardVisible,
            autoValidateMode: autoValidateMode()),
        sendButton(height, context),
      ])),
    );
  }

  // SEND BUTTON
  Align sendButton(double height, BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.45),
          child: CustomLoginButton(
            title: "Sign up",
            ontap: () {
              context.read<AuthCubit>().postUserModel();
              context.read<AuthCubit>().createFunc();
            },
          ),
        ));
  }

  // TOP TEXT WELCOME BACK
  SingleChildRenderObjectWidget topText({required height}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, height * 0.15, 0, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: isKeyboardVisible
            ? Container()
            : const TopTextWidget(title: "Create\nAccount"),
      ),
    );
  }

  AutovalidateMode autoValidateMode() {
    return state is LoginValidateState
        ? (state.isValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled)
        : AutovalidateMode.disabled;
  }
}

// Signup CONTENT
class LoginContent extends StatelessWidget {
  const LoginContent(
      {super.key,
      required this.isKeyboardVisible,
      required this.autoValidateMode});
  final bool isKeyboardVisible;
  final AutovalidateMode autoValidateMode;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: isKeyboardVisible ? height * 0.20 : height * 0.35),
      child: Align(
        alignment: Alignment.topCenter,
        child: Form(
          key: context.read<AuthCubit>().formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInputField(
                controller: context.read<AuthCubit>().createNameController,
                width: width,
                hint: "Name",
                prevIcon: const Icon(Icons.person),
              ),
              verticalSpaceTiny,
              CustomInputField(
                  controller: context.read<AuthCubit>().createEmailController,
                  prevIcon: const Icon(Icons.mail),
                  width: width,
                  hint: "Email"),
              verticalSpaceTiny,
              CustomInputField(
                  controller: context.read<AuthCubit>().createPassController,
                  prevIcon: const Icon(Icons.lock_rounded),
                  width: width,
                  hint: "PassWord",
                  passwordfeatures: true),
            ],
          ),
        ),
      ),
    );
  }
}
