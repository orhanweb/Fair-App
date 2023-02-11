import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';

Widget newRegInputField(
    {required TextEditingController controller,
    String? text,
    required BuildContext context,
    required int indexInList}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.008),
      child: TextField(
          maxLines: 5,
          minLines: 1,
          controller: controller,
          decoration: customhomeinputstyle(text)));
}
