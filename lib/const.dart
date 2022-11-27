import 'package:flutter/material.dart';

//colors
const Color kcPrimaryCascadeTwilight = Color(0xff0867e2);
const Color kcSecondaryColor = Color(0xff8CBBF1);

const Color kcMediumGreyPalladium = Color.fromARGB(255, 243, 243, 243);
const Color kcblack38 = Colors.black38;
const Color kcblack54 = Colors.black54;

//Button Font Size
const double myButtonFontSize = 18;

// BorderSide#0
BorderSide myBorderSide = const BorderSide(
  color: kcPrimaryCascadeTwilight,
  style: BorderStyle.solid,
  width: 3,
  strokeAlign: StrokeAlign.center,
);

//For Login Input Fields
OutlineInputBorder myOutlineInputBorder = OutlineInputBorder(
  borderSide: myBorderSide,
  borderRadius: BorderRadius.circular(20),
);

//ElevatedButton ReStyle
final ButtonStyle customelevatedbuttomstyle = ElevatedButton.styleFrom(
  shape: const StadiumBorder(),
  backgroundColor: kcPrimaryCascadeTwilight,
);

//OutlinedButton ReStyle
final ButtonStyle customoutlinedbuttomstyle = OutlinedButton.styleFrom(
  shape: const StadiumBorder(),
  backgroundColor: kcMediumGreyPalladium,
  side: myBorderSide.copyWith(width: 1.75),
);
