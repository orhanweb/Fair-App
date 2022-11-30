import 'package:fair_app/Home/homespecialWidgets/custom_floating_actiob_button.dart';
import 'package:fair_app/Home/homespecialWidgets/custom_listview_builder.dart';

import 'package:flutter/material.dart';

class NewRegistration extends StatelessWidget {
  final bool isKeyboardVisible;
  const NewRegistration({super.key, required this.isKeyboardVisible});

  //MAIN CONTENT
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //CUBIT
    return Scaffold(
      body: MyListViewBuilder(label: "deneme"),
      floatingActionButton: !isKeyboardVisible
          ? CustomFloatingActionButtons(
              context: context, height: height, width: width)
          : null,
    );
  }
}
