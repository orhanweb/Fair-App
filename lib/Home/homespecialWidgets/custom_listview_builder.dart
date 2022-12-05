import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyListViewBuilder extends StatelessWidget {
  const MyListViewBuilder({super.key});
  final String nolistimage = "assets/images/sticky-note.png";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<NewRegCubit, NewRegState>(
      listener: (context, state) {
        state is NewReginitialize
            ? print(state.textfieldListwithControllers.length)
            : print("BOŞ");
      },
      builder: (context, state) {
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      width: width * 0.7,
                      nolistimage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  verticalSpaceTiny,
                  Text(
                    "Liste Boş",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: kcblack54),
                  ),
                ],
              );
      },
    );
  }
}
