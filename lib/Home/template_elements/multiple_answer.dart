import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultipleAnswer extends StatelessWidget {
  final int indexInList;
  final TextEditingController controller;

  const MultipleAnswer(
      {super.key, required this.indexInList, required this.controller});

  //List<Widget> options = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: kcCuriousBlue,
              borderRadius: BorderRadius.circular(20)),
          height: (height * 0.15) +
              (state is CardListInitial
                  ? (state.newRegPageElementsList[indexInList][3].length * 60)
                  : (context
                          .read<CardListCubit>()
                          .instanceofCreateNewCard
                          .createNewCardElements[indexInList][3]
                          .length *
                      60)),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: "Sorunuz?"),
                  minLines: 1,
                  maxLines: 2,
                ),
              ),
              const SizedBox(height: 5),
              BlocBuilder<CardListCubit, CardListState>(
                builder: (context, state) {
                  return state is CardListInitial
                      ? Column(
                          children: state.newRegPageElementsList[indexInList]
                              [3],
                        )
                      : state is CreateNewCardElements
                          ? Column(
                              children: state.createNewCardElements[indexInList]
                                  [3],
                            )
                          : const SizedBox();
                },
              ),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return choiceDialog(context, indexInList: indexInList);
                  },
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: kcwhite54, foregroundColor: kcCuriousBlue),
                child: const Text("+ Add Option"),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.choiceText,
      required this.index,
      required this.indexInList})
      : super(key: key);

  final double width;
  final double height;
  final String choiceText;
  final int index;
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return InkWell(
          onTap: state is CardListInitial
              ? () {
                  if (state.newRegPageElementsList[indexInList][4].isEmpty) {
                    state.newRegPageElementsList[indexInList][4].add(index);
                    context.read<CardListCubit>().emitCardListInitial();
                  } else {
                    if (state.newRegPageElementsList[indexInList][4]
                        .contains(index)) {
                      state.newRegPageElementsList[indexInList][4]
                          .remove(index);
                      context.read<CardListCubit>().emitCardListInitial();
                    } else {
                      state.newRegPageElementsList[indexInList][4].add(index);
                      context.read<CardListCubit>().emitCardListInitial();
                    }
                  }
                }
              : () {
                  myCoolSnackBar(
                      color: kcDangerZone,
                      icon: Icons.warning_amber_rounded,
                      title: "Uyarı!",
                      description: "Şablon ekranında seçenekler işaretlenmez.",
                      textTheme: Theme.of(context).textTheme);
                },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerLeft,
            width: width * 0.8,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: state is CardListInitial
                    ? state.newRegPageElementsList[indexInList][4]
                            .contains(index)
                        ? kcParisGreen
                        : kcwhite38
                    : kcblack38,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              choiceText,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black87),
            ),
          ),
        );
      },
    );
  }
}

Widget choiceDialog(BuildContext context, {required int indexInList}) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  TextEditingController controller = TextEditingController();
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    title: const Text("Bir Seçenek Ekleyin"),
    content: TextField(
        controller: controller,
        decoration: customhomeinputstyle("Yazın.."),
        maxLength: 100),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomElevatedButton(
            backColor: kcDangerZone,
            title: const Text("İptal et"),
            height: height * 0.07,
            width: width * 0.3 > 200 ? 200 : width * 0.3,
            ontap: () => Navigator.pop(context, 'İptal Et'),
          ),
          BlocBuilder<CardListCubit, CardListState>(
            builder: (context, state) {
              return CustomElevatedButton(
                backColor: kcPrimaryCascadeTwilight,
                title: const Text("Ekle"),
                height: height * 0.07,
                width: width * 0.3 > 200 ? 200 : width * 0.3,
                ontap: () {
                  if (controller.text.isNotEmpty) {
                    if (state is CardListInitial) {
                      state.newRegPageElementsList[indexInList][3]
                          .add(ChoiceWidget(
                        width: width,
                        height: height,
                        choiceText: controller.text,
                        indexInList: indexInList,
                        index: context
                            .read<CardListCubit>()
                            .mainCardListInstance
                            .newRegPageElementsList[indexInList][3]
                            .length,
                      ));
                      context.read<CardListCubit>().emitCardListInitial();
                    } else {
                      context
                          .read<CardListCubit>()
                          .instanceofCreateNewCard
                          .createNewCardElements[indexInList][3]
                          .add(ChoiceWidget(
                            width: width,
                            height: height,
                            choiceText: controller.text,
                            indexInList: indexInList,
                            index: context
                                .read<CardListCubit>()
                                .instanceofCreateNewCard
                                .createNewCardElements[indexInList][3]
                                .length,
                          ));
                      context.read<CardListCubit>().emitcreateNewCardElements();
                    }
                  }
                  Navigator.pop(context, 'Ekle');
                },
              );
            },
          )
        ],
      )
    ],
  );
}
