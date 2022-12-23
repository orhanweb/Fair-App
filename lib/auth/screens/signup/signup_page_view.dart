import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

import 'package:fair_app/widgets/top_text_widget.dart';

import 'package:fair_app/auth/models/login_model.dart';

import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_input_field.dart';

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

  // Local Variables //
  final String _sendButtonText = "Hesap Oluştur";
  final String _topTextTitle = "Hoşgeldiniz";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    /////////////////////
    //   MAIN CONTENT  //
    /////////////////////

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
        const BackButtonWidget(),
        topText(height: height),
        LoginContent(
          isKeyboardVisible: isKeyboardVisible,
        ),
        isKeyboardVisible
            ? const SizedBox()
            : sendButton(height, width, context),
      ])),
    );
  }
  /////////////////// MAIN CONTENT END /////////////

  // SEND BUTTON
  Align sendButton(double height, double width, BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.45),
          child: CustomElevatedButton(
            backColor: kcPrimaryCascadeTwilight,
            height: height * 0.07,
            width: width * 0.9,
            title: (state is Loading)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    _sendButtonText,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: myButtonFontSize),
                  ),
            ontap: () {
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
        child: isKeyboardVisible ? null : TopTextWidget(title: _topTextTitle),
      ),
    );
  }
}

// Signup CONTENT
class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
    required this.isKeyboardVisible,
  });
  final bool isKeyboardVisible;

  //Local Variables//
  final String _nameHint = "Kullanıcı Adı";
  final String _emailHint = "Email";
  final String _passwordHint = "Şifre";

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInputField(
                controller: context.read<AuthCubit>().createNameController,
                width: width,
                hint: _nameHint,
                prevIcon: const Icon(Icons.person),
              ),
              verticalSpaceTiny,
              CustomInputField(
                  controller: context.read<AuthCubit>().createEmailController,
                  prevIcon: const Icon(Icons.mail),
                  width: width,
                  hint: _emailHint),
              verticalSpaceTiny,
              CustomInputField(
                  controller: context.read<AuthCubit>().createPassController,
                  prevIcon: const Icon(Icons.lock_rounded),
                  width: width,
                  hint: _passwordHint,
                  passwordfeatures: true),
            ],
          ),
        ),
      ),
    );
  }
}
