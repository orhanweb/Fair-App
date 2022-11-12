// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/screens/login/login_page_view.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBlocPattern extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final bool isKeyboardVisible;
  LoginBlocPattern({Key? key, required this.isKeyboardVisible})
      : super(key: key);

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            }

            if (state is Fail) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Lütfen kırmızı alanları doldurun")));
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
