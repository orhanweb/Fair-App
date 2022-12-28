import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/camera_elements.dart';
import 'package:fair_app/Home/template_elements/mic_elements.dart';
import 'package:fair_app/Home/template_elements/one_answer.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_fab.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// ignore: must_be_immutable
class NewCardCreateView extends StatelessWidget {
  NewCardCreateView({Key? key}) : super(key: key);
  String nolistimagePath =
      "assets/images/cardimages/design-and-development-process.png";
  TextEditingController templateName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return KeyboardVisibilityBuilder(
      builder: (p0, isKeyboardVisible) {
        return KeyboardDismisser(
          gestures: const [
            GestureType.onPanCancel,
            GestureType.onPanUpdateDownDirection,
          ],
          child: Scaffold(
            appBar: AppBar(
              title: MyTemplateNameWidget(templateName: templateName),
              automaticallyImplyLeading: false,
              centerTitle: true,
              actions: [
                BlocBuilder<CardListCubit, CardListState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context.read<CardListCubit>().emitCardListInitial();
                        },
                        icon: const Icon(
                          Icons.close_outlined,
                          size: 30,
                        ));
                  },
                )
              ],
            ),
            body: BlocBuilder<CardListCubit, CardListState>(
              builder: (context, state) {
                return state is CreateNewCardElements &&
                        state.createNewCardElements.isNotEmpty
                    ? MyCustomListWidget(
                        height: height,
                        builderList: state.createNewCardElements)
                    : NoDataColumn(
                        height: height,
                        width: width,
                        nolistimagePath: nolistimagePath,
                        text: "Yeni Bir Alan Ekleyin");
              },
            ),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: !isKeyboardVisible
                ? ExpandableButtons(templateName: templateName)
                : null,
          ),
        );
      },
    );
  }
}

class MyTemplateNameWidget extends StatelessWidget {
  const MyTemplateNameWidget({
    Key? key,
    required this.templateName,
  }) : super(key: key);

  final TextEditingController templateName;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.7,
      child: TextField(
        textAlign: TextAlign.center,
        controller: templateName,
        cursorColor: kcwhite,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w500, fontSize: 18, color: kcwhite),
        decoration: InputDecoration(
            hintText: "Şablonun Adı",
            hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: kcwhite54,
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                )),
      ),
    );
  }
}

class MyCustomListWidget extends StatelessWidget {
  const MyCustomListWidget({
    Key? key,
    required this.height,
    required this.builderList,
  }) : super(key: key);

  final double height;
  final List builderList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: height * 0.015),
        physics: const BouncingScrollPhysics(),
        itemCount: builderList.length,
        itemBuilder: (context, index) {
          return builderList[index][1];
        });
  }
}

class ExpandableButtons extends StatelessWidget {
  const ExpandableButtons({
    Key? key,
    required this.templateName,
  }) : super(key: key);

  final TextEditingController templateName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return ExpandableFab(
            openButtonHeroTag: "opening",
            closeButtonHeroTag: "closing",
            distance: 70,
            backgroundColor: kcPrimaryCascadeTwilight,
            closeButtonStyle: const ExpandableFabCloseButtonStyle(
                backgroundColor: kcDangerZone,
                foregroundColor: kcwhite,
                child: Icon(
                  Icons.more_vert_outlined,
                  size: 40,
                )),
            type: ExpandableFabType.up,
            child: const Icon(
              Icons.more_horiz_outlined,
              size: 40,
            ),
            children: [
              myfloatingActionButton(
                heroTag: "5",
                icon: Icons.question_answer_outlined,
                toolTip: "Soru Sorun",
                onPressed: () async {
                  //context.read<CardListCubit>().addCameraField();
                  context
                      .read<CardListCubit>()
                      .instanceofCreateNewCard
                      .createNewCardElements
                      .add(["ONEANSWER", OneAnswer()]);
                  context.read<CardListCubit>().emitcreateNewCardElements();
                },
              ),
              myfloatingActionButton(
                heroTag: "4",
                icon: Icons.mic_outlined,
                toolTip: "Ses kaydedin",
                onPressed: () async {
                  //context.read<CardListCubit>().addCameraField();
                  context
                      .read<CardListCubit>()
                      .instanceofCreateNewCard
                      .createNewCardElements
                      .add([
                    "MIC",
                    MicCustom(
                        indexInList: context
                            .read<CardListCubit>()
                            .instanceofCreateNewCard
                            .createNewCardElements
                            .length)
                  ]);
                  context.read<CardListCubit>().emitcreateNewCardElements();
                },
              ),
              myfloatingActionButton(
                heroTag: "3",
                icon: Icons.photo_camera,
                toolTip: "Camerayı Açın",
                onPressed: () async {
                  //context.read<CardListCubit>().addCameraField();
                  context
                      .read<CardListCubit>()
                      .instanceofCreateNewCard
                      .createNewCardElements
                      .add([
                    "CAMERA",
                    CameraElements(
                        indexInList: context
                            .read<CardListCubit>()
                            .instanceofCreateNewCard
                            .createNewCardElements
                            .length),
                    null
                  ]);
                  context.read<CardListCubit>().emitcreateNewCardElements();
                },
              ),
              myfloatingActionButton(
                heroTag: "2",
                icon: Icons.edit,
                toolTip: "Yeni Alan Ekleyin",
                onPressed: () {
                  context.read<CardListCubit>().addTextField(context: context);
                },
              ),
              myfloatingActionButton(
                heroTag: "1",
                icon: Icons.save,
                toolTip: "Şablonu Kaydedin",
                onPressed: () {
                  if (templateName.text.isNotEmpty ||
                      state is CreateNewCardElements) {
                    context.read<CardListCubit>().saveTheNewCard(
                        context: context, templateName: templateName.text);
                  } else {
                    myCoolSnackBar(
                        color: kcDangerZone,
                        icon: Icons.warning_amber_rounded,
                        title: "Uyarı!",
                        description: "Şablon Adı Girilmelidir",
                        textTheme: Theme.of(context).textTheme);
                  }
                },
              ),
            ]);
      },
    );
  }
}
