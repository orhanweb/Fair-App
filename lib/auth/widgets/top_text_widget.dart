import 'package:fair_app/auth/shared/beautification.dart';
import 'package:flutter/material.dart';

class TopTextWidget extends StatelessWidget {
  const TopTextWidget({
    Key? key,
    required this.width,
    required this.heigth,
    required this.title,
  }) : super(key: key);

// Parameters
  final double width;
  final double heigth;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.fromLTRB(width * 0.03, heigth * 0.12, 0, heigth * 0.02),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3?.copyWith(
              color: kcPrimaryCascadeTwilight, fontWeight: FontWeight.w500),
        ));
  }
}
