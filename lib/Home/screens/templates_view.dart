import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/screens/new_template_create_view.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grock/grock.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({Key? key}) : super(key: key);
  final String noCardImage = "assets/images/cardimages/wireframe.png";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<CardListCubit, CardListState>(
        builder: (context, state) {
          return state is CardListInitial && state.mainCardList.isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.01),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.mainCardList.length,
                  itemBuilder: (context, index) {
                    return state.mainCardList[index];
                  },
                )
              : NoDataColumn(
                  height: height,
                  width: width,
                  nolistimagePath: noCardImage,
                  text: "Şablon Listeniz Boş",
                );
        },
      ),
      floatingActionButton: BlocBuilder<CardListCubit, CardListState>(
        builder: (context, state) {
          return CustomElevatedButton(
            backColor: kcPrimaryCascadeTwilight,
            title: const Text("Yeni Şablon Oluştur"),
            height: height,
            width: width * 0.55,
            ontap: () {
              Grock.to(NewCardCreateView());
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
