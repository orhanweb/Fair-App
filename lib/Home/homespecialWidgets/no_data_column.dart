import 'package:fair_app/Core/Constants/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class NoDataColumn extends StatelessWidget {
  const NoDataColumn({
    Key? key,
    required this.width,
    required this.height,
    required this.nolistimagePath,
    this.text,
  }) : super(key: key);

  final double width;
  final double height;
  final String nolistimagePath;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            width: width * 0.7 < height ? width * 0.6 : height * 0.6,
            nolistimagePath,
            fit: BoxFit.contain,
          ),
        ),
        verticalSpaceTiny,
        Text(
          text ?? "",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: kcblack54),
        ),
      ],
    );
  }
}
