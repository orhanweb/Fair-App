// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/screens/login/login_page_view.dart';
import 'package:fair_app/widgets/custom_snack_bar.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocPattern extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController loginUsernameController = TextEditingController();
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
            loginUsernameController: loginUsernameController,
            loginPasswordController: loginPasswordController),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is UserDisabled) {
              mySnackBar(
                  context: context,
                  title: "Bu e posta sistem tarafından geçersiz kılınmıştır.");
            } else if (state is UserNotFound) {
              mySnackBar(
                  context: context,
                  title: "Bu kullanıcı adı ile hesap oluşturulmamış.");
            } else if (state is WrongPassword) {
              mySnackBar(context: context, title: "Şifrenizi yanlış girdiniz.");
            }
            if (state is Fail) {
              mySnackBar(
                  context: context, title: "Lütfen tüm alanları doldurun");
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
