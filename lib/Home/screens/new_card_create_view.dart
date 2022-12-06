import 'package:fair_app/Home/models/home_card_list_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:fair_app/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class NewCardCreateView extends StatelessWidget {
  const NewCardCreateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return KeyboardDismisser(
      gestures: const [GestureType.onPanCancel],
      child: Scaffold(
        appBar: AppBar(
            title: TextField(
          cursorColor: Colors.white,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.w500, fontSize: 18, color: kcwhite),
          decoration: InputDecoration(
              hintText: "Şablonun Adı",
              hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: kcwhite54,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  )),
        )),
        body: ListView.separated(
          padding: EdgeInsets.only(top: height * 0.015),
          separatorBuilder: (context, index) => verticalSpaceTiny,
          physics: const BouncingScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return index + 1 != 2
                ? CustomInputField(
                    width: width, prevIcon: const Icon(Icons.apple))
                : IconButton(onPressed: () {}, icon: const Icon(Icons.add));
          },
        ),
        floatingActionButton: BlocBuilder<CardListCubit, CardListState>(
          builder: (context, state) {
            return CustomElevatedButton(
              title: const Text("Şablonu Kaydet"),
              height: height * 0.08,
              width: width * 0.5,
              ontap: () {
                context.read<CardListCubit>().addNewCardToCardList(
                  titleName: "Bunu Ben ekledim",
                  elements: ["Şu", "Bu", "Sen", "Başardın", "al"],
                );
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
