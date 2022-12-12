import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({super.key});
  final String nolistimage = "assets/images/sticky-note.png";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return state is CardListInitial &&
                state.newRegPageElementsList.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(top: height * 0.01),
                //separatorBuilder: (context, index) => verticalSpaceTiny,
                physics: const BouncingScrollPhysics(),
                itemCount: state.newRegPageElementsList.length,
                itemBuilder: (context, index) {
                  //print(state.newRegPageElementsList);
                  return state.newRegPageElementsList[index];
                })
            : NoDataColumn(
                height: height,
                width: width,
                nolistimagePath: nolistimage,
                text: "Burası Çok Issız Yeni Alan Ekleyin",
              );
      },
    );
  }
}
