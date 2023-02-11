import 'package:flutter/material.dart';

//colors
const Color kcPrimaryCascadeTwilight = Color(0xff0867e2);
const Color kcSecondaryColor = Color(0xff8CBBF1);
const Color kcParisGreen = Color(0xff4dca83);
const Color kcCuriousBlue = Color(0xff3EA4E0);

const Color kc3thColor = Color.fromARGB(255, 23, 82, 150);
const Color kcMediumGreyPalladium = Color.fromARGB(255, 243, 243, 243);
const Color kcGrey = Color.fromARGB(253, 196, 196, 196);
const Color kcDangerZone = Color.fromARGB(255, 221, 47, 47);

const Color kcblack38 = Colors.black38;
const Color kcblack45 = Colors.black45;
const Color kcblack54 = Colors.black54;
const Color kcwhite = Colors.white;
const Color kcwhite54 = Colors.white54;
const Color kcwhite38 = Colors.white38;

//Button Font Size
const double myButtonFontSize = 18;

// BorderSide#0
BorderSide myBorderSide = const BorderSide(
  color: kcPrimaryCascadeTwilight,
  style: BorderStyle.solid,
  width: 1.75,
  strokeAlign: BorderSide.strokeAlignCenter,
);

//For Login Input Fields
OutlineInputBorder myOutlineInputBorder = OutlineInputBorder(
  borderSide: myBorderSide,
  borderRadius: BorderRadius.circular(20),
);

// My Rounded Rectangle Border
const RoundedRectangleBorder myRoundedRectangleBorder =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));

//ElevatedButton ReStyle
final ButtonStyle customelevatedbuttomstyle = ElevatedButton.styleFrom(
  shape: myRoundedRectangleBorder,
  backgroundColor: kcPrimaryCascadeTwilight,
);

//OutlinedButton ReStyle
final ButtonStyle customoutlinedbuttomstyle = OutlinedButton.styleFrom(
  shape: myRoundedRectangleBorder,
  backgroundColor: kcMediumGreyPalladium,
  side: myBorderSide,
);

// Input Border Style
InputDecoration customhomeinputstyle(String? text) {
  return InputDecoration(
      label: Text(text ?? "Konu Adı (Gerekli)"), border: myOutlineInputBorder);
}
