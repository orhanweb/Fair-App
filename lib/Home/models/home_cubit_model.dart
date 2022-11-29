import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class NewRegCubit extends Cubit<NewRegState> {
  NewRegCubit() : super(NewRegInitial());

  Widget addnewElement(String label) {
    TextEditingController controller = TextEditingController();

    print("Yeni Veriyi Ekliyorum");

    return newRegInputField(controller, label);
  }
}

abstract class NewRegState {}

class NewRegInitial extends NewRegState {}
