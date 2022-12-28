import 'package:fair_app/Home/homespecialWidgets/custom_dialog.dart';
import 'package:fair_app/Home/homespecialWidgets/custom_listview_builder.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/camera_elements.dart';
import 'package:fair_app/Home/template_elements/mic_elements.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_fab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import '../template_elements/one_answer.dart';

class NewRegistration extends StatelessWidget {
  final bool isKeyboardVisible;
  const NewRegistration({super.key, required this.isKeyboardVisible});

  //MAIN CONTENT
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MyListViewBuilder(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: !isKeyboardVisible
          ? BlocBuilder<CardListCubit, CardListState>(
              builder: (context, state) {
                return ExpandableFab(
                    openButtonHeroTag: "openingNewReg",
                    closeButtonHeroTag: "closingNewReg",
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
                        heroTag: "2",
                        icon: Icons.edit,
                        toolTip: "Yeni Alan Ekleyin",
                        onPressed: () => showDialog(
                            context: context, builder: mycustomDialog),
                      ),
                      myfloatingActionButton(
                        heroTag: "3",
                        icon: Icons.photo_camera,
                        toolTip: "Camerayı Açın",
                        onPressed: () async {
                          context
                              .read<CardListCubit>()
                              .mainCardListInstance
                              .newRegPageElementsList
                              .add([
                            "CAMERA",
                            CameraElements(
                              onTapUse: true,
                              indexInList: (context
                                  .read<CardListCubit>()
                                  .mainCardListInstance
                                  .newRegPageElementsList
                                  .length),
                            ),
                            null
                          ]);
                          context.read<CardListCubit>().emitCardListInitial();
                        },
                      ),
                      myfloatingActionButton(
                        heroTag: "4",
                        icon: Icons.mic_outlined,
                        toolTip: "Ses kaydedin",
                        onPressed: () async {
                          context
                              .read<CardListCubit>()
                              .mainCardListInstance
                              .newRegPageElementsList
                              .add([
                            "MIC",
                            MicCustom(
                                onTapUse: true,
                                indexInList: context
                                    .read<CardListCubit>()
                                    .mainCardListInstance
                                    .newRegPageElementsList
                                    .length),
                          ]);
                          context.read<CardListCubit>().emitCardListInitial();
                        },
                      ),
                      myfloatingActionButton(
                        heroTag: "5",
                        icon: Icons.question_answer_outlined,
                        toolTip: "Soru Sorun",
                        onPressed: () async {
                          //context.read<CardListCubit>().addCameraField();
                          context
                              .read<CardListCubit>()
                              .mainCardListInstance
                              .newRegPageElementsList
                              .add(["ONEANSWER", OneAnswer()]);
                          context.read<CardListCubit>().emitCardListInitial();
                        },
                      ),
                    ]);
              },
            )
          : null,
    );
  }
}
