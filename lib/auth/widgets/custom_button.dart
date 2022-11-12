import 'package:fair_app/auth/shared/beautification.dart';
import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton(
      {super.key, required this.title, this.ontap, this.style});
  final void Function()? ontap;
  final String title;
  final ButtonStyle? style;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: style,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

//  ElevatedButton.styleFrom(
//           backgroundColor: kcPrimaryCascadeTwilight,
//           shape: const StadiumBorder()),