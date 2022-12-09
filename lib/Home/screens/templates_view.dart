import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/homespecialWidgets/templates_cart_design.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/models/home_newreg_model.dart';
import 'package:fair_app/Home/screens/new_template_create_view.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({Key? key}) : super(key: key);
  final String noCardImage = "assets/images/cardimages/wireframe.png";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<NewRegCubit, NewRegState>(
        builder: (newregcontext, newregstate) {
          return BlocBuilder<CardListCubit, CardListState>(
            builder: (context, state) {
              return state is CardListInitial && state.mainCardList.isNotEmpty
                  ? ReorderableListView.builder(
                      padding: EdgeInsets.only(top: height * 0.01),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.mainCardList.length,
                      itemBuilder: (context, index) => DesignedCard(
                        key: ValueKey(index),
                        titleName: state.mainCardList[index][0],
                        onTap: () {
                          newregcontext
                              .read<NewRegCubit>()
                              .cleartextfieldListwithControllers();
                          for (String title in state.mainCardList[index][1]) {
                            newregcontext
                                .read<NewRegCubit>()
                                .addnewElement(text: title, context: context);
                          }
                        },
                      ),
                      onReorder: (oldIndex, newIndex) => context
                          .read<CardListCubit>()
                          .onReorderCardList(oldIndex, newIndex),
                    )
                  : NoDataColumn(
                      width: width,
                      nolistimagePath: noCardImage,
                      text: "Şablon Listeniz Boş",
                    );
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<CardListCubit, CardListState>(
        builder: (context, state) {
          return CustomElevatedButton(
            backColor: kcPrimaryCascadeTwilight,
            title: const Text("Yeni Şablon Oluştur"),
            height: height * 0.08,
            width: width * 0.5,
            ontap: () {
              Get.to(NewCardCreateView());
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
