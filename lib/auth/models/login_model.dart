import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final TextEditingController? loginEmailController;
  final TextEditingController? loginPasswordController;

  final TextEditingController? createNameController;
  final TextEditingController? createEmailController;
  final TextEditingController? createPassController;
  final TextEditingController nullCheck = TextEditingController();
  bool isLoginFail = false;

  final GlobalKey<FormState> formKey;
  AuthCubit(
      {this.createEmailController,
      this.createPassController,
      this.createNameController,
      this.loginEmailController,
      this.loginPasswordController,
      required this.formKey})
      : super(LoginInitial());

  Future<void> loginFunc() async {
    if ((loginEmailController ?? nullCheck).text.isEmpty ||
        (loginPasswordController ?? nullCheck).text.isEmpty) {
      print("Lütfen gerekli alanları doldurun");
      emit(Fail());
    } else {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: (loginEmailController ?? nullCheck).text.trim(),
          password: (loginPasswordController ?? nullCheck).text.trim());

      emit(LoginSucces());
    }
  }

  Future<void> createFunc() async {
    if ((createEmailController ?? nullCheck).text.isEmpty ||
        (createPassController ?? nullCheck).text.isEmpty ||
        (createNameController ?? nullCheck).text.isEmpty) {
      print("Lütfen gerekli alanları doldurun");
      emit(Fail());
    } else {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: (createEmailController ?? nullCheck).text.trim(),
          password: (createPassController ?? nullCheck).text.trim());

      emit(CreateSucces());
    }
  }

  void postUserModel() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO:service
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isValidate: isLoginFail));
    }
  }
}

abstract class AuthState {}

class LoginInitial extends AuthState {}

class LoginValidateState extends AuthState {
  final bool isValidate;

  LoginValidateState({required this.isValidate});
}

class LoginSucces extends AuthState {}

class CreateSucces extends AuthState {}

class Fail extends AuthState {}
