import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

import 'package:fair_app/widgets/top_text_widget.dart';

import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_input_field.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageView extends StatelessWidget {
  final BuildContext context;
  final dynamic state;
  final bool isKeyboardVisible;

  const LoginPageView(
      {Key? key,
      required this.context,
      this.state,
      required this.isKeyboardVisible})
      : super(key: key);

  // Local Variables
  final String _sendButtonText = "Giriş Yap";
  final String _topTextTitle = "Tekrardan\nHoşgeldiniz";
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
        sendButton(height, width, context),
      ])),
    );
  }
  /////////////////// MAIN CONTENT END /////////////

  // SEND BUTTON
  Align sendButton(double height, double width, BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.4),
          child: CustomOutlinedButton(
            height: height * 0.07,
            width: width * 0.9,
            title: state is Loading
                ? const CircularProgressIndicator(
                    color: kcPrimaryCascadeTwilight,
                  )
                : Text(
                    _sendButtonText,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: kcPrimaryCascadeTwilight,
                        fontWeight: FontWeight.bold,
                        fontSize: myButtonFontSize),
                  ),
            ontap: () {
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
            : TopTextWidget(title: _topTextTitle),
      ),
    );
  }
}

// LOGIN CONTENT
class LoginContent extends StatelessWidget {
  const LoginContent({
    super.key,
    required this.isKeyboardVisible,
  });
  final bool isKeyboardVisible;

  // Local Variables
  final String _nameHint = "Kullanıcı Adı";
  final String _passwordHint = "Şifre";
  final String _forgotpasswordText = "Şifrenizi mi unuttunuz?";

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
                controller: context.read<AuthCubit>().loginUsernameController,
                prevIcon: const Icon(Icons.person),
                width: width,
                hint: _nameHint,
              ),
              verticalSpaceTiny,
              CustomInputField(
                controller: context.read<AuthCubit>().loginPasswordController,
                prevIcon: const Icon(Icons.lock_rounded),
                width: width,
                hint: _passwordHint,
                passwordfeatures: true,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.45),
                child: TextButton(
                    onPressed: () {},
                    child: Text(_forgotpasswordText,
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
