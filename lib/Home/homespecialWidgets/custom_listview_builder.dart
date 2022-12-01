import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewRegCubit, NewRegState>(
      builder: (context, state) {
        print(
            "List view eleman sayısı ve tipi: ${state.runtimeType} ${state.runtimeType}");
        return state is NewReginitialize &&
                state.textfieldListwithControllers.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => verticalSpaceTiny,
                physics: const BouncingScrollPhysics(),
                itemCount: state.textfieldListwithControllers.length,
                itemBuilder: (context, index) {
                  return state.textfieldListwithControllers[index][1];
                },
              )
            : Center(
                child: Text(
                "Liste Boş",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: kcblack54),
              ));
      },
    );
  }
}
