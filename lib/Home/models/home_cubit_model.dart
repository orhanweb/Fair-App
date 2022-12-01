import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
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

  void addnewElement(String text) {
    final TextEditingController controller = TextEditingController();
    final List newElementList = [];

    newElementList.add(controller);
    newElementList.add(newRegInputField(controller, text));
    newElementList.add(text);
    textfieldListwithControllers.add(newElementList);

    emit(NewReginitialize(
        textfieldListwithControllers: textfieldListwithControllers));
  }

  Future<void> write(BuildContext contextforSnackBar) async {
    bool isShowSnackBar = false;
    Map<String, dynamic> sendtoFireStore = {};
    for (var i = 0; i < textfieldListwithControllers.length; i++) {
      if (textfieldListwithControllers[i][0].text.isEmpty) {
        if (!isShowSnackBar) {
          isShowSnackBar = true;
          mySnackBar(
              contextforSnackBar, "Boş bırakılan alanlar dikkate alınmadı!");
        }
        continue;
      }
      sendtoFireStore["${textfieldListwithControllers[i][2]}"] =
          "${textfieldListwithControllers[i][0].text}";

      textfieldListwithControllers[i][0].clear();
    }
    if (sendtoFireStore.isNotEmpty) {
      await _firestore
          .collection("Users")
          .doc("admin")
          .collection("Kayıtlar")
          .doc("Kayıt1")
          .set(sendtoFireStore);
      print(sendtoFireStore);
      emit(NewReginitialize(
          textfieldListwithControllers: textfieldListwithControllers));
    }
  }
}

abstract class NewRegState {}

class NewReginitialize extends NewRegState {
  final List<List> textfieldListwithControllers;
  NewReginitialize({required this.textfieldListwithControllers});
}
