import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

Widget newRegInputField(TextEditingController controller, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: TextField(
      controller: controller,
      decoration: customhomeinputstyle(text),
    ),
  );
}
