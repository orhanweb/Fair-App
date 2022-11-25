import 'package:fair_app/firebase_options.dart';
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
  final GlobalKey<FormState> formKey;
  bool isLoginFail = false;

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
      emit(Fail());
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: (loginEmailController ?? nullCheck).text.trim(),
            password: (loginPasswordController ?? nullCheck).text.trim());

        emit(LoginSucces());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          emit(InvalidEmail());
        } else if (e.code == 'user-disabled') {
          emit(UserDisabled());
        } else if (e.code == 'user-not-found') {
          emit(UserNotFound());
        } else if (e.code == 'wrong-password') {
          emit(WrongPassword());
        }
      }
    }
  }

  Future<void> createFunc() async {
    if ((createEmailController ?? nullCheck).text.isEmpty ||
        (createPassController ?? nullCheck).text.isEmpty ||
        (createNameController ?? nullCheck).text.isEmpty) {
      emit(Fail());
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: (createEmailController ?? nullCheck).text.trim(),
            password: (createPassController ?? nullCheck).text.trim());

        emit(CreateSucces());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          emit(EmailAlreadyUse());
        } else if (e.code == 'invalid-email') {
          emit(InvalidEmail());
        }
      }
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

//Text inputları için oluşturulan class
class LoginValidateState extends AuthState {
  final bool isValidate;

  LoginValidateState({required this.isValidate});
}

// Login sayfası için kullanılan classlar
class LoginSucces extends AuthState {}

class UserDisabled extends AuthState {}

class UserNotFound extends AuthState {}

class WrongPassword extends AuthState {}

//Hesap oluşturma için kullanılan classlar
class CreateSucces extends AuthState {}

class EmailAlreadyUse extends AuthState {}

// Ortak kullanılan classlar
class Fail extends AuthState {}

class InvalidEmail extends AuthState {}
