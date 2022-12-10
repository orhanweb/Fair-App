import 'package:flutter/material.dart';

import 'package:grock/grock.dart';

void myCoolSnackBar(
    {IconData? icon,
    String? title,
    String? description,
    Color? color,
    TextTheme? textTheme}) {
  Grock.snackBar(
      leading: Icon(icon, size: 35),
      title: title ?? "Title",
      description: description ?? "Description",
      color: color,
      duration: const Duration(milliseconds: 1800),
      titleStyle: textTheme?.subtitle1?.copyWith(fontWeight: FontWeight.bold),
      descriptionStyle: textTheme?.subtitle2);
}
