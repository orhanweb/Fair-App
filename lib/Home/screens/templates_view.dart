import 'package:fair_app/Home/homespecialWidgets/templates_cart_design.dart';
import 'package:fair_app/Home/models/home_card_list_cubit.dart';
import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:fair_app/Home/screens/new_card_create_view.dart';
import 'package:fair_app/Home/screens/new_registration.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TemplatesView extends StatelessWidget {
  const TemplatesView({Key? key}) : super(key: key);
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
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.mainCardList.length,
                      itemBuilder: (context, index) => DesignedCard(
                        titleName: state.mainCardList[index][0],
                        onTap: () {
                          newregcontext
                              .read<NewRegCubit>()
                              .cleartextfieldListwithControllers();
                          for (String title in state.mainCardList[index][1]) {
                            newregcontext
                                .read<NewRegCubit>()
                                .addnewElement(title);
                          }
                        },
                      ),
                    )
                  : const Center(
                      child: Text("Card Listesi Boş"),
                    );
            },
          );
        },
      ),
      floatingActionButton: CustomElevatedButton(
        title: const Text("Yeni Şablon Oluştur"),
        height: height * 0.08,
        width: width * 0.5,
        ontap: () {
          Get.to(const NewCardCreateView());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
