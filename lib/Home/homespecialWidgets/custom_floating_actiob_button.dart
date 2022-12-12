import 'package:fair_app/Home/models/home_newreg_model.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/text_field_elements.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_divider.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// CUSTOM FLOATING ACTION BUTTON
class CustomFloatingActionButtons extends StatelessWidget {
  const CustomFloatingActionButtons({
    Key? key,
    required this.height,
    required this.width,
    required this.context,
  }) : super(key: key);

  final BuildContext context;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<NewRegCubit, NewRegState>(
            builder: (context, state) {
              return FloatingActionButton(
                heroTag: "Add",
                onPressed: () =>
                    showDialog(context: context, builder: mycustomDialog),
                backgroundColor: kcPrimaryCascadeTwilight,
                child: const Icon(Icons.add),
              );
            },
          ),
          verticalSpaceTiny,
          BlocBuilder<NewRegCubit, NewRegState>(
            builder: (context, state) {
              return FloatingActionButton(
                heroTag: "SendToCloud",
                onPressed: () {
                  context.read<NewRegCubit>().writetoFirebase(context);
                },
                backgroundColor: kcPrimaryCascadeTwilight,
                child: const Icon(Icons.cloud_upload_outlined),
              );
            },
          ),
        ],
      ),
    );
  }
}

//Add floatingactionbutton Later

// showModalBottomSheet(
//               context: context,
//               builder: mycustomBottomSheet,
//               shape: const RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(30))),
//               elevation: 50,
//             ),
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
        BlocBuilder<NewRegCubit, NewRegState>(
          builder: (context, state) {
            return CustomElevatedButton(
              backColor: kcPrimaryCascadeTwilight,
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              ontap: () {
                context.read<NewRegCubit>().writetoFirebase(context);
              },
            );
          },
        ),
      ],
    ),
  );
}

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
                context
                    .read<CardListCubit>()
                    .mainCardListInstance
                    .newRegPageElementsList
                    .add(newRegInputField(
                        controller: TextEditingController(),
                        context: context,
                        text: dialogcontroller.text));
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
