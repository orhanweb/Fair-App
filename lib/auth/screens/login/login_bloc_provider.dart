// ignore_for_file: depend_on_referenced_packages
import 'package:fair_app/auth/Cubit/login_cubit.dart';
import 'package:fair_app/auth/screens/login/login_page_view.dart';
import 'package:fair_app/Core/Constants/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';

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
              myCoolSnackBar(
                  icon: Icons.warning_amber_rounded,
                  title: "Uyarı!",
                  color: kcDangerZone,
                  description: "Bu e posta sistem tarafından engellenmiştir.",
                  textTheme: Theme.of(context).textTheme);
            } else if (state is UserNotFound) {
              myCoolSnackBar(
                  icon: Icons.warning_amber_rounded,
                  title: "Uyarı!",
                  color: kcDangerZone,
                  description: "Bu kullanıcı adı ile hesap oluşturulmamış.",
                  textTheme: Theme.of(context).textTheme);
            } else if (state is WrongPassword) {
              myCoolSnackBar(
                  icon: Icons.warning_amber_rounded,
                  title: "Uyarı!",
                  color: kcDangerZone,
                  description: "Şifrenizi yanlış girdiniz.",
                  textTheme: Theme.of(context).textTheme);
            }
            if (state is Fail) {
              myCoolSnackBar(
                  icon: Icons.warning_amber_rounded,
                  title: "Uyarı!",
                  color: kcDangerZone,
                  description: "Lütfen tüm alanları doldurun",
                  textTheme: Theme.of(context).textTheme);
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
