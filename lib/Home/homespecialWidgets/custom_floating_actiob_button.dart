import 'package:fair_app/Home/screens/new_registration.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';

// CUSTOM FLOATING ACTION BUTTON
class CustomFloatingActionButtons extends StatelessWidget {
  const CustomFloatingActionButtons({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
                showDialog(context: context, builder: mycustomDialog),
            backgroundColor: kcPrimaryCascadeTwilight,
            child: const Icon(Icons.add),
          ),
          verticalSpaceTiny,
          FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: mycustomBottomSheet,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30))),
              elevation: 50,
            ),
            backgroundColor: kcPrimaryCascadeTwilight,
            child: const Icon(Icons.cloud_upload_outlined),
          ),
        ],
      ),
    );
  }
}
