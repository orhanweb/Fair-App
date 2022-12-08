import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewRegCubit extends Cubit<NewRegState> {
  NewRegCubit({required this.textfieldListwithControllers})
      : super(NewReginitialize(
            textfieldListwithControllers: textfieldListwithControllers));

  final List<List> textfieldListwithControllers;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //////////////////////////////////////////////////////////
  //                  ADD NEW ELEMENT                     //
  //////////////////////////////////////////////////////////
  void addnewElement({required String text, required BuildContext context}) {
    final TextEditingController controller = TextEditingController();
    final List newElementList = [];

    newElementList.add(controller);
    newElementList.add(
        newRegInputField(controller: controller, context: context, text: text));
    newElementList.add(text);
    textfieldListwithControllers.add(newElementList);

    emit(NewReginitialize(
        textfieldListwithControllers: textfieldListwithControllers));
  }
  //FUNC END : ADD NEW ELEMENT

  //////////////////////////////////////////////////////////
  //                SEND FORM TO FIREBASE                 //
  //////////////////////////////////////////////////////////
  Future<void> writetoFirebase(BuildContext contextforSnackBar) async {
    bool isShowSnackBar = false;
    int bosmu = 0;
    Map<String, dynamic> sendtoFireStore = {};
    if (textfieldListwithControllers.isNotEmpty) {
      for (var i = 0; i < textfieldListwithControllers.length; i++) {
        if (textfieldListwithControllers[i][0].text.isEmpty) {
          bosmu++;
        }
      }
      if (bosmu == textfieldListwithControllers.length) {
        mySnackBar(contextforSnackBar, "Oluşturulan liste boş");
      } else {
        for (var i = 0; i < textfieldListwithControllers.length; i++) {
          if (textfieldListwithControllers[i][0].text.isEmpty) {
            if (!isShowSnackBar) {
              isShowSnackBar = true;
              mySnackBar(contextforSnackBar,
                  "Boş bırakılan alanlar dikkate alınmadı!");
            }
            continue;
          }
          sendtoFireStore["${textfieldListwithControllers[i][2]}"] =
              "${textfieldListwithControllers[i][0].text}";

          textfieldListwithControllers[i][0].clear();
        }
        if (sendtoFireStore.values.isNotEmpty) {
          try {
            await _firestore
                .collection("Users")
                .doc("admin")
                .collection("Kayıtlar")
                .doc("Kayıt1")
                .set(sendtoFireStore)
                .then(
              (value) {
                mySnackBar(contextforSnackBar, "Başarıyla Gönderildi");
              },
            );
          } on FirebaseException {
            mySnackBar(contextforSnackBar,
                "Kaydınız Gönderilirken Bir Sorun Oluştu Lütfen Tekrar Deneyiniz");
          }
        }
      }

      emit(NewReginitialize(
          textfieldListwithControllers: textfieldListwithControllers));
    } else {
      mySnackBar(contextforSnackBar, "Boş Liste Gönderilemez");
    }
  }

  //FUNC END : SEND FORM TO FIREBASE

  void cleartextfieldListwithControllers() {
    textfieldListwithControllers.clear();
    emit(NewReginitialize(
        textfieldListwithControllers: textfieldListwithControllers));
  }

  void onReorderNewReg(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = textfieldListwithControllers.removeAt(oldIndex);
    textfieldListwithControllers.insert(newIndex, item);
    emit(NewReginitialize(
        textfieldListwithControllers: textfieldListwithControllers));
  }
}

abstract class NewRegState {}

class NewReginitialize extends NewRegState {
  final List<List> textfieldListwithControllers;
  NewReginitialize({required this.textfieldListwithControllers});
}
