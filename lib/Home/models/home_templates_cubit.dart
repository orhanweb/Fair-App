import 'package:fair_app/Home/homespecialWidgets/newreg_input_field_widget.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CardListCubit extends Cubit<CardListState> {
  CardListCubit({required this.mainCardList})
      : super(CardListInitial(mainCardList: mainCardList));

  final List<List> mainCardList;
  CreateNewCardElements instanceofCreateNewCard =
      CreateNewCardElements(createNewCardElements: []);

  void addField({required BuildContext context}) {
    final List addOnefield = [];
    final TextEditingController controller = TextEditingController();
    addOnefield.add(controller);
    addOnefield.add(newRegInputField(controller: controller, context: context));
    instanceofCreateNewCard.createNewCardElements.add(addOnefield);
    emit(CreateNewCardElements(
        createNewCardElements: instanceofCreateNewCard.createNewCardElements));
  }

  void addNewCardToCardList(
      {required String titleName, required List<String> elements}) {
    final List addCardFeatures = [];

    addCardFeatures.add(titleName);
    addCardFeatures.add(elements);
    mainCardList.add(addCardFeatures);
    emit(CardListInitial(mainCardList: mainCardList));
  }

  /////// SAVE THE NEW TEMPLATE
  void saveTheNewCard(
      {required BuildContext context, required String templateName}) {
    List<String> elements = [];
    bool isemptyBox = false; // Is empty template text fields
    int isAllEmpy = 0;
    if (instanceofCreateNewCard.createNewCardElements.isNotEmpty) {
      for (int i = 0;
          i < instanceofCreateNewCard.createNewCardElements.length;
          i++) {
        if (instanceofCreateNewCard
            .createNewCardElements[i][0].text.isNotEmpty) {
          elements
              .add(instanceofCreateNewCard.createNewCardElements[i][0].text);
        } else {
          isAllEmpy++;
          isemptyBox = true;
        }
      }
      if (isAllEmpy == instanceofCreateNewCard.createNewCardElements.length) {
        myCoolSnackBar(
            color: kcDangerZone,
            icon: Icons.warning_amber_rounded,
            title: "Uyarı!",
            description: "En az 1 alan doldurmalısınız.",
            textTheme: Theme.of(context).textTheme);
      } else {
        if (isemptyBox) {
          myCoolSnackBar(
              color: kcDangerZone,
              icon: Icons.warning_amber_rounded,
              title: "Uyarı!",
              description: "Boş Alanlar Dikkate Alınmadı",
              textTheme: Theme.of(context).textTheme);
        }
        myCoolSnackBar(
            color: kcParisGreen,
            icon: Icons.download_done_outlined,
            title: "Güzel Haber!",
            description: "Şablon Kaydedildi",
            textTheme: Theme.of(context).textTheme);
        deleteOldCardInfo();
        addNewCardToCardList(titleName: templateName, elements: elements);

        Navigator.pop(context);
      }
    } else {
      myCoolSnackBar(
          color: kcDangerZone,
          icon: Icons.warning_amber_rounded,
          title: "Uyarı!",
          description: "En az 1 alan girip doldurmalısınız",
          textTheme: Theme.of(context).textTheme);
    }
  }

  void deleteOldCardInfo() {
    instanceofCreateNewCard.createNewCardElements.clear();
    emit(CreateNewCardElements(
        createNewCardElements: instanceofCreateNewCard.createNewCardElements));
  }

  //CARD ELEMENTS ITEMS REORDER FUNC
  void onReorderCreateCardElements(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item =
        instanceofCreateNewCard.createNewCardElements.removeAt(oldIndex);
    instanceofCreateNewCard.createNewCardElements.insert(newIndex, item);
    emit(CreateNewCardElements(
        createNewCardElements: instanceofCreateNewCard.createNewCardElements));
  }

  //MAIN CARD LİST REORDER FUNC
  void onReorderCardList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = mainCardList.removeAt(oldIndex);
    mainCardList.insert(newIndex, item);
    emit(CardListInitial(mainCardList: mainCardList));
  }
}

abstract class CardListState {}

class CardListInitial extends CardListState {
  final List<List> mainCardList;

  CardListInitial({required this.mainCardList});
}

class CreateNewCardElements extends CardListState {
  final List<List> createNewCardElements;

  CreateNewCardElements({required this.createNewCardElements});
}
