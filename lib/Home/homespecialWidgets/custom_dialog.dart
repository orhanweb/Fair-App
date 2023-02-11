import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/text_field_elements.dart';
import 'package:fair_app/Core/Constants/const.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///  DIALOG NEW SPACE
Widget mycustomDialog(BuildContext buttoncontext) {
  double width = MediaQuery.of(buttoncontext).size.width;
  double height = MediaQuery.of(buttoncontext).size.height;
  TextEditingController dialogcontroller = TextEditingController();
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    title: const Text("Yeni Alan Ekleyin"),
    content: TextField(
        maxLength: 25,
        controller: dialogcontroller,
        decoration: customhomeinputstyle("Alanın Başlığı")),
    actions: [
      CustomElevatedButton(
        backColor: kcDangerZone,
        title: const Text("İptal et"),
        height: height * 0.07,
        width: width * 0.3 > 200 ? 200 : width * 0.3,
        ontap: () => Navigator.pop(buttoncontext, 'İptal Et'),
      ),
      BlocBuilder<CardListCubit, CardListState>(
        builder: (context, state) {
          return CustomElevatedButton(
            backColor: kcPrimaryCascadeTwilight,
            title: const Text("Ekle"),
            height: height * 0.07,
            width: width * 0.3 > 200 ? 200 : width * 0.3,
            ontap: () {
              if (dialogcontroller.text.isNotEmpty) {
                TextEditingController controller = TextEditingController();
                context
                    .read<CardListCubit>()
                    .mainCardListInstance
                    .newRegPageElementsList
                    .add([
                  "TEXTFIELD",
                  newRegInputField(
                      controller: controller,
                      context: context,
                      text: dialogcontroller.text,
                      indexInList: (context
                          .read<CardListCubit>()
                          .mainCardListInstance
                          .newRegPageElementsList
                          .length)),
                  controller
                ]);
                context.read<CardListCubit>().emitCardListInitial();
                Navigator.pop(context, 'Ekle');
              } else {
                myCoolSnackBar(
                    color: kcDangerZone,
                    icon: Icons.warning_amber_rounded,
                    title: "Uyarı!",
                    description: "Başlık alanı boş bırakılamaz",
                    textTheme: Theme.of(context).textTheme);
              }
            },
          );
        },
      ),
    ],
    actionsAlignment: MainAxisAlignment.spaceEvenly,
  );
}
