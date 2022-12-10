import 'package:fair_app/Home/homespecialWidgets/no_data_column.dart';
import 'package:fair_app/Home/models/home_newreg_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({super.key});
  final String nolistimage = "assets/images/sticky-note.png";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<NewRegCubit, NewRegState>(
      builder: (context, state) {
        return state is NewReginitialize &&
                state.textfieldListwithControllers.isNotEmpty
            ? ReorderableListView.builder(
                padding: EdgeInsets.only(top: height * 0.01),
                //separatorBuilder: (context, index) => verticalSpaceTiny,
                physics: const BouncingScrollPhysics(),
                itemCount: state.textfieldListwithControllers.length,
                itemBuilder: (context, index) {
                  return state.textfieldListwithControllers[index][1];
                },
                onReorder: (oldIndex, newIndex) => context
                    .read<NewRegCubit>()
                    .onReorderNewReg(oldIndex, newIndex),
              )
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
