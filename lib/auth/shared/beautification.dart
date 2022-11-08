import 'package:flutter/material.dart';

//colors
const Color kcPrimaryCascadeTwilight = Color(0xff1d70c9);
const Color kcMediumGreyPalladium = Color(0xffb0b0b0);

//text
const TextStyle ktsMediumBodyText =
    TextStyle(color: kcMediumGreyPalladium, fontSize: kBodyTextSize);

//Font Sizing
const double kBodyTextSize = 16;

// Screen Size Helpers

double screenHeigth(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeightPersentage(BuildContext context, {double persentage = 1}) =>
    screenHeigth(context) * persentage;

double screenWidthPersentage(BuildContext context, {double persentage = 1}) =>
    screenWidth(context) * persentage;
