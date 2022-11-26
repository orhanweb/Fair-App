// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/screens/login/login_page_view.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocPattern extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final bool isKeyboardVisible;
  LoginBlocPattern({
    Key? key,
    required this.isKeyboardVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(
            formKey: formKey,
            loginEmailController: loginEmailController,
            loginPasswordController: loginPasswordController),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSucces) {
              Get.to(const HomeView());
            } else if (state is InvalidEmail) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Lütfen geçerli bir Mail giriniz")));
            } else if (state is UserDisabled) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Bu e posta sistem tarafından geçersiz kılınmıştır.")));
            } else if (state is UserNotFound) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Bu e posta ile hesap oluşturulmamış.")));
            } else if (state is WrongPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Şifrenizi yanlış girdiniz.")));
            }
            if (state is Fail) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Lütfen tüm alanları doldurun")));
            }
          },
          builder: (context, state) {
            return LoginPageView(
              isKeyboardVisible: isKeyboardVisible,
              context: context,
              state: state,
            );
          },
        ));
  }
}
