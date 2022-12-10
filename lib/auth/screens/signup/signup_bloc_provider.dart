import 'package:fair_app/auth/models/login_model.dart';
import 'package:fair_app/auth/screens/signup/signup_page_view.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';

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
            myCoolSnackBar(
                color: kcDangerZone,
                icon: Icons.warning_amber_rounded,
                title: "Uyarı!",
                description: "Girdiğiniz mail zaten kullanılıyor.",
                textTheme: Theme.of(context).textTheme);
          } else if (state is InvalidEmail) {
            myCoolSnackBar(
                color: kcDangerZone,
                icon: Icons.warning_amber_rounded,
                title: "Uyarı!",
                description: "Lütfen geçerli bir Mail giriniz",
                textTheme: Theme.of(context).textTheme);
          } else if (state is UserNameAlreadyUse) {
            myCoolSnackBar(
                color: kcDangerZone,
                icon: Icons.warning_amber_rounded,
                title: "Uyarı!",
                description: "Bu Kullanıcı adı alınmış.",
                textTheme: Theme.of(context).textTheme);
          }
          if (state is Fail) {
            myCoolSnackBar(
                color: kcDangerZone,
                icon: Icons.warning_amber_rounded,
                title: "Uyarı!",
                description: "Lütfen tüm alanları doldurun",
                textTheme: Theme.of(context).textTheme);
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
