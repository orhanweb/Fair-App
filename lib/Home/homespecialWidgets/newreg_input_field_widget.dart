import 'package:fair_app/shared/const.dart';
import 'package:flutter/material.dart';

Widget newRegInputField(
    {required TextEditingController controller,
    String? text,
    required BuildContext context}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  return Row(
    key: ObjectKey(controller),
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.008),
        child: SizedBox(
          width: width * 0.85,
          child: TextField(
            maxLines: 5,
            minLines: 1,
            controller: controller,
            decoration: customhomeinputstyle(text),
          ),
        ),
      ),
      Icon(
        Icons.read_more_rounded,
        size: width * 0.085,
      )
    ],
  );
}
