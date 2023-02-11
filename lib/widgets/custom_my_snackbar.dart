import 'package:flutter/material.dart';

import 'package:grock/grock.dart';

void myCoolSnackBar(
    {IconData? icon,
    String? title,
    String? description,
    Color? color,
    Widget? trailing,
    TextTheme? textTheme}) {
  Grock.snackBar(
      leading: Icon(icon, size: 35),
      title: title ?? "Title",
      description: description ?? "Description",
      color: color,
      blur: 10,
      trailing: trailing,
      openDuration: const Duration(milliseconds: 1000),
      duration: const Duration(milliseconds: 2000),
      titleStyle: textTheme?.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      descriptionStyle: textTheme?.titleSmall);
}
