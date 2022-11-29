import 'package:fair_app/Home/homespecialWidgets/custom_floating_actiob_button.dart';
import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:fair_app/Home/homespecialWidgets/custom_listview_builder.dart';
import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewRegistration extends StatelessWidget {
  final bool isKeyboardVisible;
  const NewRegistration({super.key, required this.isKeyboardVisible});

  //MAIN CONTENT
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => NewRegCubit(),
      child: Scaffold(
        body: MyListViewBuilder(label: "deneme"),
        floatingActionButton: !isKeyboardVisible
            ? CustomFloatingActionButtons(height: height, width: width)
            : null,
      ),
    );
  }
}

// SEND CLOUD BOTTOM SHEET
Widget mycustomBottomSheet(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return SizedBox(
    height: height * 0.16,
    child: Column(
      children: [
        verticalSpaceTiny,
        myDivider(),
        verticalSpaceTiny,
        CustomElevatedButton(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.cloud_upload_outlined),
            horizontalSpaceTiny,
            Text(
              "Cloud'a Yükle",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: kcwhite),
            ),
          ]),
          height: height * 0.07,
          width: width * 0.5,
          ontap: () {},
        ),
      ],
    ),
  );
}

///  DIALOG NEW SPACE
Widget mycustomDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  TextEditingController dialogcontroller = TextEditingController();
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    title: const Text("Yeni Alan Ekleyin"),
    content: newRegInputField(dialogcontroller, "Alanın başlığını girin..."),
    actions: [
      CustomElevatedButton(
        title: const Text("İptal et"),
        height: height * 0.07,
        width: width * 0.3,
        ontap: () => Navigator.pop(context, 'İptal Et'),
      ),
      BlocBuilder<NewRegCubit, NewRegState>(
        builder: (context, state) {
          return CustomElevatedButton(
            title: const Text("Ekle"),
            height: height * 0.07,
            width: width * 0.3,
            ontap: () {
              context.read<NewRegCubit>().addnewElement(dialogcontroller.text);
              print(dialogcontroller.text);
            },
          );
        },
      ),
    ],
    actionsAlignment: MainAxisAlignment.spaceEvenly,
  );
}
