import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class NoDataColumn extends StatelessWidget {
  const NoDataColumn({
    Key? key,
    required this.width,
    required this.nolistimagePath,
    this.text,
  }) : super(key: key);

  final double width;
  final String nolistimagePath;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            width: width * 0.7,
            nolistimagePath,
            fit: BoxFit.contain,
          ),
        ),
        verticalSpaceTiny,
        Text(
          text ?? "",
          style:
              Theme.of(context).textTheme.headline6?.copyWith(color: kcblack54),
        ),
      ],
    );
  }
}
