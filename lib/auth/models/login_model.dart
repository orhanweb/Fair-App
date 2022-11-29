import 'package:fair_app/Home/screens/home.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthCubit extends Cubit<AuthState> {
  final TextEditingController? loginPasswordController;
  final TextEditingController? loginUsernameController;

  final TextEditingController? createNameController;
  final TextEditingController? createEmailController;
  final TextEditingController? createPassController;
  final TextEditingController nullCheck = TextEditingController();
  final GlobalKey<FormState> formKey;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoginFail = false;

  AuthCubit(
      {this.loginUsernameController,
      this.createEmailController,
      this.createPassController,
      this.createNameController,
      this.loginPasswordController,
      required this.formKey})
      : super(LoginInitial());

  //////////////////////////////////////////////////////////
  //                  LOGIN A ACCOUNT                    //
  //////////////////////////////////////////////////////////
  Future<void> loginFunc() async {
    if ((loginUsernameController ?? nullCheck).text.isEmpty ||
        (loginPasswordController ?? nullCheck).text.isEmpty) {
      emit(Fail());
    } else {
      emit(Loading());

      try {
        QuerySnapshot<Map<String, dynamic>> snapEmail = await _firestore
            .collection("Users")
            .where("userName", isEqualTo: loginUsernameController!.text)
            .get();
        if (snapEmail.size == 0) {
          emit(UserNotFound());
        } else {
          await _auth
              .signInWithEmailAndPassword(
                  email: snapEmail.docs[0]["email"],
                  password: (loginPasswordController ?? nullCheck).text.trim())
              .then((value) {
            Get.to(HomeView(username: snapEmail.docs[0]["userName"]));
          });
          emit(Succes());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-disabled') {
          emit(UserDisabled());
        } else if (e.code == 'wrong-password') {
          emit(WrongPassword());
        }
      }
    }
  }

  //////////////////////////////////////////////////////////
  //                  CREATE A ACCOUNT                    //
  //////////////////////////////////////////////////////////
  Future<void> createFunc() async {
    if ((createEmailController ?? nullCheck).text.isEmpty ||
        (createPassController ?? nullCheck).text.isEmpty ||
        (createNameController ?? nullCheck).text.isEmpty) {
      emit(Fail());
    } else {
      try {
        emit(Loading());

        QuerySnapshot<Map<String, dynamic>> snapUserName = await _firestore
            .collection("Users")
            .where("userName", isEqualTo: createNameController?.text)
            .get();
        if (snapUserName.size == 0) {
          final user = await _auth.createUserWithEmailAndPassword(
              email: (createEmailController ?? nullCheck).text.trim(),
              password: (createPassController ?? nullCheck).text.trim());

          await _firestore.collection("Users").doc(user.user!.uid).set({
            'userName': createNameController!.text,
            'email': createEmailController!.text
          }).then((value) =>
              {Get.to(HomeView(username: createNameController!.text))});
          emit(Succes());
        } else {
          emit(UserNameAlreadyUse());
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          emit(EmailAlreadyUse());
        } else if (e.code == 'invalid-email') {
          emit(InvalidEmail());
        }
      }
    }
  }

  //////////////////////////////////////////////////////////
  //                    CUSTOM SNACKBAR                   //
  //////////////////////////////////////////////////////////
  void mySnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: kcMediumGreyPalladium,
          ),
          const HorizontalSpacers(boyut: 0.02),
          Text(title)
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: kcPrimaryCascadeTwilight,
    ));
  }
}

abstract class AuthState {}

class LoginInitial extends AuthState {}

// Login sayfası için kullanılan classlar

class UserDisabled extends AuthState {}

class UserNotFound extends AuthState {}

class WrongPassword extends AuthState {}

//Hesap oluşturma için kullanılan classlar
class EmailAlreadyUse extends AuthState {}

class UserNameAlreadyUse extends AuthState {}

// Ortak kullanılan classlar
class Fail extends AuthState {}

class Succes extends AuthState {}

class InvalidEmail extends AuthState {}

class Loading extends AuthState {}
