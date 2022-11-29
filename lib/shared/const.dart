import 'package:flutter/material.dart';

//colors
const Color kcPrimaryCascadeTwilight = Color(0xff0867e2);
const Color kcSecondaryColor = Color(0xff8CBBF1);
const Color kc3thColor = Color.fromARGB(255, 23, 82, 150);

const Color kcMediumGreyPalladium = Color.fromARGB(255, 243, 243, 243);
const Color kcblack38 = Colors.black38;
const Color kcblack45 = Colors.black45;
const Color kcblack54 = Colors.black54;
const Color kcwhite = Colors.white;
const Color kcwhite54 = Colors.white54;

//Button Font Size
const double myButtonFontSize = 18;

// BorderSide#0
BorderSide myBorderSide = const BorderSide(
  color: kcPrimaryCascadeTwilight,
  style: BorderStyle.solid,
  width: 1.75,
  strokeAlign: StrokeAlign.center,
);

//For Login Input Fields
OutlineInputBorder myOutlineInputBorder = OutlineInputBorder(
  borderSide: myBorderSide,
  borderRadius: BorderRadius.circular(20),
);

//ElevatedButton ReStyle
final ButtonStyle customelevatedbuttomstyle = ElevatedButton.styleFrom(
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))),
  backgroundColor: kcPrimaryCascadeTwilight,
);

//OutlinedButton ReStyle
final ButtonStyle customoutlinedbuttomstyle = OutlinedButton.styleFrom(
  shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20))),
  backgroundColor: kcMediumGreyPalladium,
  side: myBorderSide,
);
