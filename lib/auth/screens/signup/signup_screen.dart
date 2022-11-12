import 'dart:ffi';

import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/shared/helpers.widget.dart';
import 'package:fair_app/auth/widgets/custom_button.dart';
import 'package:fair_app/auth/widgets/custom_input_field.dart';
import 'package:fair_app/auth/widgets/top_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController createNameController = TextEditingController();
  final TextEditingController createEmailController = TextEditingController();
  final TextEditingController createPassController = TextEditingController();

  CreateAccountScreen(
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
    return BlocProvider(
      create: (context) => AuthCubit(
        formKey: formKey,
        createNameController: createNameController,
        createEmailController: createEmailController,
        createPassController: createPassController,
      ),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state is CreateSucces
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ))
              : const Center(
                  child: CircularProgressIndicator(),
                );
          state is Fail
              ? ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Lütfen tüm alanları doldurun")))
              : Container();
        },
        builder: (context, state) {
          return BuildScaffold(
              context: context,
              state: state,
              isKeyboardVisible: isKeyboardVisible,
              width: width,
              heigth: heigth);
        },
      ),
    );
  }
}

class BuildScaffold extends StatelessWidget {
  const BuildScaffold({
    Key? key,
    required this.isKeyboardVisible,
    required this.width,
    required this.heigth,
    required this.context,
    required this.state,
  }) : super(key: key);

  final bool isKeyboardVisible;
  final double width;
  final double heigth;
  final BuildContext context;
  // ignore: prefer_typing_uninitialized_variables
  final state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(fit: StackFit.expand, children: [
        topTextVisibilty(),
        Padding(
          padding: EdgeInsets.only(
              top: isKeyboardVisible ? heigth * 0.20 : heigth * 0.35),
          child: Align(
            alignment: Alignment.topCenter,
            child: Form(
              key: context.read<AuthCubit>().formKey,
              autovalidateMode: autoValidateMode(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  CustomInputField(
                    controller: context.read<AuthCubit>().createNameController,
                    width: width,
                    hint: "Name",
                    prevIcon: const Icon(Icons.person),
                  ),
                  verticalSpaceTiny,
                  CustomInputField(
                      controller:
                          context.read<AuthCubit>().createEmailController,
                      prevIcon: const Icon(Icons.mail),
                      width: width,
                      hint: "Email"),
                  verticalSpaceTiny,
                  CustomInputField(
                      controller:
                          context.read<AuthCubit>().createPassController,
                      prevIcon: const Icon(Icons.lock_rounded),
                      width: width,
                      hint: "PassWord",
                      passwordfeatures: true),
                ],
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: heigth * 0.4),
              child: CustomLoginButton(
                title: "Sign up",
                ontap: () {
                  context.read<AuthCubit>().postUserModel();
                  context.read<AuthCubit>().createFunc();
                },
              ),
            )),
      ])),
    );
  }

  StatelessWidget topTextVisibilty() {
    return isKeyboardVisible
        ? Container()
        : TopTextWidget(title: "Create\nAccount");
  }

  AutovalidateMode autoValidateMode() {
    return state is LoginValidateState
        ? (state.isValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled)
        : AutovalidateMode.disabled;
  }
}
