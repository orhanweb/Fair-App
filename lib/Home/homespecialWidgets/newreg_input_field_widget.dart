import 'package:flutter/material.dart';

Widget newRegInputField(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    maxLength: 25,
    decoration: InputDecoration(
        hintText: label,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)))),
  );
}
