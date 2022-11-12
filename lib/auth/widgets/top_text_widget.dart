import 'package:fair_app/auth/shared/beautification.dart';
import 'package:flutter/material.dart';

class TopTextWidget extends StatelessWidget {
  const TopTextWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

// Parameters

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context).textTheme.headline3?.copyWith(
            color: kcPrimaryCascadeTwilight,
            fontWeight: FontWeight.w500,
          ),
    );
  }
}
