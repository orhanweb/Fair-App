import 'package:fair_app/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {super.key,
      required this.title,
      this.ontap,
      required this.height,
      required this.width});

  final double height;
  final double width;

  final void Function()? ontap;
  final Widget title;
  final ButtonStyle _style = customelevatedbuttomstyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: ontap,
        style: _style,
        child: title,
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  CustomOutlinedButton(
      {super.key,
      required this.title,
      this.ontap,
      required this.height,
      required this.width});

  final double height;
  final double width;

  final void Function()? ontap;
  final Widget title;
  final ButtonStyle _style = customoutlinedbuttomstyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: ontap,
        style: _style,
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
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded)),
    );
  }
}
