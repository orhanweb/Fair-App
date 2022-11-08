import 'package:fair_app/auth/shared/beautification.dart';
import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryCascadeTwilight,
          shape: const StadiumBorder()),
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
