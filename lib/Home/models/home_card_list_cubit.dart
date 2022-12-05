import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardListCubit extends Cubit<CardListState> {
  CardListCubit({required this.mainCardList})
      : super(CardListInitial(mainCardList: mainCardList));

  final List<List> mainCardList;
  final NewRegCubit newregcubit = NewRegCubit(textfieldListwithControllers: []);

  List addNewCard(
      {required String imagePath,
      required Function goWhere,
      required String titleofCard}) {
    final List oneCardMade = [];

    oneCardMade.add(imagePath);
    oneCardMade.add(titleofCard);

    //newregcubit.cleartextfieldListwithControllers();
    // for (var titlename in titleofInputs) {
    //   newregcubit.addnewElement(titlename);
    // }

    return oneCardMade;

    //newregcubit.addnewElement("");
  }
}

abstract class CardListState {}

class CardListInitial extends CardListState {
  final List<List> mainCardList;

  CardListInitial({required this.mainCardList});
}
