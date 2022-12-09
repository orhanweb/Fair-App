import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_FAB.dart';
import 'package:fair_app/widgets/custom_snack_bar.dart';
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
            appBar:
                AppBar(title: MyTemplateNameWidget(templateName: templateName)),
            body: BlocBuilder<CardListCubit, CardListState>(
              builder: (context, state) {
                return state is CreateNewCardElements &&
                        state.createNewCardElements.isNotEmpty
                    ? MyCustomListWidget(
                        height: height,
                        onReorder: (oldIndex, newIndex) => context
                            .read<CardListCubit>()
                            .onReorderCreateCardElements(oldIndex, newIndex),
                        builderList: state.createNewCardElements)
                    : NoDataColumn(
                        width: width,
                        nolistimagePath: nolistimagePath,
                        text: "Yeni Bir Alan Ekleyin");
              },
            ),
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: BlocBuilder<CardListCubit, CardListState>(
              builder: (context, state) {
                return ExpandableFab(
                    openButtonHeroTag: "eeee",
                    distance: 70,
                    onOpen: () {
                      mySnackBar(context: context, title: "girdi");
                    },
                    backgroundColor: kcPrimaryCascadeTwilight,
                    closeButtonStyle: ExpandableFabCloseButtonStyle(
                        backgroundColor: kcDangerZone,
                        foregroundColor: kcwhite,
                        child: Icon(
                          Icons.more_vert_outlined,
                          size: width * 0.11,
                        )),
                    type: ExpandableFabType.up,
                    child: Icon(
                      Icons.more_horiz_outlined,
                      size: width * 0.11,
                    ),
                    children: [
                      myfloatingActionButton(
                        heroTag: "1",
                        icon: Icons.edit,
                        toolTip: "Yeni Alan Ekleyin",
                        onPressed: () {
                          context
                              .read<CardListCubit>()
                              .addField(context: context);
                        },
                      ),
                      myfloatingActionButton(
                        heroTag: "2",
                        icon: Icons.save,
                        toolTip: "Şablonu Kaydedin",
                        onPressed: () {
                          if (templateName.text.isNotEmpty &&
                              state is CreateNewCardElements) {
                            context.read<CardListCubit>().saveTheNewCard(
                                context: context,
                                templateName: templateName.text);
                          } else {
                            mySnackBar(
                                key: ValueKey(templateName.text),
                                context: context,
                                title: "Şablon Adı Boş Bırakılamaz");
                          }
                        },
                      )
                    ]);
              },
            ),
          ),
        );
      },
    );
  }
}

//  floatingActionButton: !isKeyboardVisible
//                 ? MyFloatingButtons(
//                     height: height, width: width, templateName: templateName)
//                 : null,
//             floatingActionButtonLocation:
//                 FloatingActionButtonLocation.centerFloat,

class MyTemplateNameWidget extends StatelessWidget {
  const MyTemplateNameWidget({
    Key? key,
    required this.templateName,
  }) : super(key: key);

  final TextEditingController templateName;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: templateName,
      cursorColor: kcwhite,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18, color: kcwhite),
      decoration: InputDecoration(
          hintText: "Şablonun Adı",
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: kcwhite54,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              )),
    );
  }
}

class MyCustomListWidget extends StatelessWidget {
  const MyCustomListWidget({
    Key? key,
    required this.height,
    required this.builderList,
    required this.onReorder,
  }) : super(key: key);

  final double height;
  final List builderList;
  final void Function(int, int) onReorder;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: ReorderableListView.builder(
              padding: EdgeInsets.only(top: height * 0.015),
              physics: const BouncingScrollPhysics(),
              itemCount: builderList.length,
              itemBuilder: (context, index) {
                return builderList[index][1];
              },
              onReorder: onReorder),
        ),
        Expanded(flex: 1, child: Container())
      ],
    );
  }
}
