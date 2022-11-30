import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NewRegCubit extends Cubit<List> {
  NewRegCubit({required this.textfieldList, required this.controllers})
      : super([]);
  final List textfieldList;
  final List controllers;

  void publishcontrollers() {
    emit(controllers);
    print(
        "Cloud button view eleman sayısı ve tipi: ${state.runtimeType} ${state.runtimeType}");
  }

  void addnewElement(String text) {
    final TextEditingController controller = TextEditingController();
    textfieldList.add(newRegInputField(controller, text));
    controllers.add(controller);

    emit(textfieldList);
  }
}

abstract class NewRegState {}

class NewRegInitial extends NewRegState {}

// class GetText extends NewRegState {
//   final List<Widget> textfieldList;

//   GetText({required this.textfieldList});
// }
