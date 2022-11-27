import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/screens/signup/signup_page_view.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBlocProvider extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController createNameController = TextEditingController();
  final TextEditingController createEmailController = TextEditingController();
  final TextEditingController createPassController = TextEditingController();

  SignupBlocProvider({
    Key? key,
    required this.isKeyboardVisible,
  }) : super(key: key);

  final bool isKeyboardVisible;

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
          if (state is EmailAlreadyUse) {
            context.read<AuthCubit>().mySnackBar(context,
                "Girdiğiniz E-Mail zaten kullanılıyor. Lütfen Oturum açmayı deneyin");
          } else if (state is InvalidEmail) {
            context
                .read<AuthCubit>()
                .mySnackBar(context, "Lütfen geçerli bir Mail giriniz");
          } else if (state is UserNameAlreadyUse) {
            context
                .read<AuthCubit>()
                .mySnackBar(context, "Bu Kullanıcı adı alınmış.");
          }
          if (state is Fail) {
            context
                .read<AuthCubit>()
                .mySnackBar(context, "Lütfen tüm alanları doldurun");
          }
        },
        builder: (context, state) {
          return SignupPageView(
            context: context,
            state: state,
            isKeyboardVisible: isKeyboardVisible,
          );
        },
      ),
    );
  }
}
