import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

class MyListViewBuilder extends StatelessWidget {
  MyListViewBuilder({super.key, required this.label});

  int itemcount = 1;
  final TextEditingController controller = TextEditingController();
  final String label;

  Widget newelement(BuildContext context, int index) {
    itemcount++;
    print(index);

    return newRegInputField(controller, label);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => verticalSpaceTiny,
      physics: const BouncingScrollPhysics(),
      itemCount: itemcount,
      itemBuilder: newelement,
    );
  }
}
