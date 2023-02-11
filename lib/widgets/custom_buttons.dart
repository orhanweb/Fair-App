import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';

import 'package:grock/grock.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.title,
    this.ontap,
    required this.height,
    required this.width,
    this.backColor,
  });

  final double height;
  final double width;

  final void Function()? ontap;
  final Widget title;
  final Color? backColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700 < height ? height * 0.07 : 50,
      width: width - 300 < height ? width * 0.9 : 800,
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor ?? kcPrimaryCascadeTwilight,
          shape: myRoundedRectangleBorder,
        ),
        child: title,
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.title,
    this.ontap,
    required this.height,
    required this.width,
    this.backColor,
  });

  final double height;
  final double width;

  final void Function()? ontap;
  final Widget title;
  final Color? backColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700 < height ? height * 0.07 : 50,
      width: width - 300 < height ? width * 0.9 : 800,
      child: OutlinedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backColor ?? kcblack54,
          shape: myRoundedRectangleBorder,
        ),
        child: title,
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          onPressed: () {
            Grock.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }
}
