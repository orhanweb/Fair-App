import 'package:flutter/material.dart';

import 'package:fair_app/auth/widgets/back_button.dart';
import 'package:fair_app/auth/widgets/top_text_widget.dart';

import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/shared/beautification.dart';
import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:fair_app/auth/widgets/custom_button.dart';
import 'package:fair_app/auth/widgets/custom_input_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageView extends StatelessWidget {
  final bool isKeyboardVisible;
  final BuildContext context;
  final state;

  const LoginPageView(
      {Key? key,
      required this.isKeyboardVisible,
      required this.context,
      this.state})
      : super(key: key);
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
        send(height, context),
      ])),
    );
  }

  Align send(double height, BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.4),
          child: CustomLoginButton(
            title: "Sign in",
            ontap: () {
              context.read<AuthCubit>().postUserModel();
              context.read<AuthCubit>().loginFunc();
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
            : const TopTextWidget(title: "Welcome\nBack"),
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

// LOGIN CONTENT
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
                controller: context.read<AuthCubit>().loginEmailController,
                prevIcon: const Icon(Icons.mail),
                width: width,
                hint: "Email",
                validator: (value) =>
                    (value ?? "").length > 10 ? "" : 'Emaili tekrar giriniz',
              ),
              verticalSpaceTiny,
              CustomInputField(
                controller: context.read<AuthCubit>().loginPasswordController,
                prevIcon: const Icon(Icons.lock_rounded),
                width: width,
                hint: "PassWord",
                passwordfeatures: true,
                validator: (value) =>
                    (value ?? "").length > 6 ? "" : 'Şifreniz yanlış',
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.55),
                child: TextButton(
                    onPressed: () {},
                    child: Text("Forgot Password?",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: kcPrimaryCascadeTwilight))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
