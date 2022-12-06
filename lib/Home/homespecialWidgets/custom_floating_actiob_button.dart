import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_divider.dart';
import 'package:fair_app/widgets/custom_snack_bar.dart';
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
                print("Clouda Gönder");
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
Widget mycustomDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
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
              if (dialogcontroller.text.isNotEmpty) {
                context
                    .read<NewRegCubit>()
                    .addnewElement(dialogcontroller.text);
                Navigator.pop(context, 'Ekle');
              } else {
                mySnackBar(context, "Başlık alanı boş bırakılamaz");
              }
            },
          );
        },
      ),
    ],
    actionsAlignment: MainAxisAlignment.spaceEvenly,
  );
}
