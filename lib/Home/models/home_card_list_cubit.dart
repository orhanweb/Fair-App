import 'package:fair_app/Home/models/home_cubit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardListCubit extends Cubit<CardListState> {
  CardListCubit({required this.mainCardList})
      : super(CardListInitial(mainCardList: mainCardList));

  final List<List> mainCardList;
  final NewRegCubit deneme = NewRegCubit(textfieldListwithControllers: []);

  void addNewCardToCardList(
      {required String titleName, required List<String> elements}) {
    final List addCardFeatures = [];

    addCardFeatures.add(titleName);
    addCardFeatures.add(elements);
    mainCardList.add(addCardFeatures);
    emit(CardListInitial(mainCardList: mainCardList));
  }
}

abstract class CardListState {}

class CardListInitial extends CardListState {
  final List<List> mainCardList;

  CardListInitial({required this.mainCardList});
}
