import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListViewBuilder extends StatelessWidget {
  MyListViewBuilder({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewRegCubit, List>(
      listener: (context, state) {},
      builder: (context, state) {
        print(
            "List view eleman sayısı ve tipi: ${state.runtimeType} ${state.runtimeType}");
        return state.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, index) => verticalSpaceTiny,
                physics: const BouncingScrollPhysics(),
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return state[index];
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
