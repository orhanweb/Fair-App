import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

//////////////////////////////////////////////////////////
//                    CUSTOM SNACKBAR                   //
//////////////////////////////////////////////////////////
void mySnackBar(BuildContext context, String title) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
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
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 10,
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    backgroundColor: kcPrimaryCascadeTwilight,
  ));
}
