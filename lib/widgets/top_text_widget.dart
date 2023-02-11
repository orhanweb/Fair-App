import 'package:fair_app/Core/Constants/const.dart';
import 'package:flutter/material.dart';

class TopTextWidget extends StatelessWidget {
  const TopTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  // Parameter
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: kcPrimaryCascadeTwilight,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
