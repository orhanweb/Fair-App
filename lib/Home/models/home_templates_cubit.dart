import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:fair_app/Home/homespecialWidgets/templates_card_design.dart';
import 'package:fair_app/Home/template_elements/camera_elements.dart';
import 'package:fair_app/Home/template_elements/mic_elements.dart';
import 'package:fair_app/Home/template_elements/one_answer.dart';
import 'package:fair_app/Home/template_elements/text_field_elements.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// SAME THING TEMPLATE = CARD

class CardListCubit extends Cubit<CardListState> {
  CardListCubit()
      : super(CardListInitial(mainCardList: [], newRegPageElementsList: []));

  CardListInitial mainCardListInstance =
      CardListInitial(mainCardList: [], newRegPageElementsList: []);
  CreateNewCardElements instanceofCreateNewCard =
      CreateNewCardElements(createNewCardElements: []);

  //////////////////////////////////////////////////////////
  //         ADD TEXT FIELD TO NEW CARD ELEMENTS          //
  //////////////////////////////////////////////////////////
  void addTextField({required BuildContext context}) {
    final List addOnefield = [];
    final TextEditingController controller = TextEditingController();
    addOnefield.add("TEXTFIELD");
    addOnefield.add(newRegInputField(
        controller: controller,
        context: context,
        indexInList: instanceofCreateNewCard.createNewCardElements.length));
    addOnefield.add(controller);
    instanceofCreateNewCard.createNewCardElements.add(addOnefield);
    emit(CreateNewCardElements(
        createNewCardElements: instanceofCreateNewCard.createNewCardElements));
  }
  //FUNC END : ADD TEXT FIELD

  // Future<void> addCameraField() async {
  //   final List addOneCameraField = [];
  //   PermissionStatus status = await Permission.camera.request();
  //   if (status.isGranted) {
  //     myCoolSnackBar(
  //         title: "Güzel Haber!",
  //         description: "Kamera izni açıldı",
  //         icon: Icons.settings_sharp,
  //         color: kcParisGreen);
  //     addOneCameraField.add("CAMERA");
  //     addOneCameraField.add(CameraElements(
  //       indexInList: instanceofCreateNewCard.createNewCardElements.length,
  //     ));
  //     print("object");
  //     instanceofCreateNewCard.createNewCardElements.add(addOneCameraField);
  //     emit(CreateNewCardElements(
  //         createNewCardElements:
  //             instanceofCreateNewCard.createNewCardElements));
  //   } else if (status.isDenied) {
  //     myCoolSnackBar(
  //         title: "Uyarı!",
  //         description: "Kamera iznini açmak için tıkla",
  //         icon: Icons.settings_sharp,
  //         trailing: const IconButton(
  //           onPressed: openAppSettings,
  //           icon: Icon(Icons.double_arrow_outlined),
  //         ),
  //         color: kcDangerZone);
  //   }
  // }

  /////////////////////////////////////////////////////////
  //                   SAVE THE NEW CARD                 //
  /////////////////////////////////////////////////////////
  void saveTheNewCard(
      {required BuildContext context, required String templateName}) {
    int numberOfEmtpyRequiredFields = 0;
    if (templateName.isNotEmpty) {
      List<List> elements = [];
      if (instanceofCreateNewCard.createNewCardElements.isNotEmpty) {
        for (int index = 0;
            index < instanceofCreateNewCard.createNewCardElements.length;
            index++) {
          if (instanceofCreateNewCard.createNewCardElements[index][0] ==
              "TEXTFIELD") {
            if (instanceofCreateNewCard
                .createNewCardElements[index][2].text.isNotEmpty) {
              TextEditingController controller = TextEditingController();

              elements.add([
                "TEXTFIELD",
                newRegInputField(
                    controller: controller,
                    context: context,
                    text: instanceofCreateNewCard
                        .createNewCardElements[index][2].text,
                    indexInList: elements.length),
                controller
              ]);
            } else {
              numberOfEmtpyRequiredFields++;
            }
          } else if (instanceofCreateNewCard.createNewCardElements[index][0] ==
              "CAMERA") {
            elements.add([
              "CAMERA",
              CameraElements(onTapUse: true, indexInList: elements.length),
              null
            ]);
          } else if (instanceofCreateNewCard.createNewCardElements[index][0] ==
              "MIC") {
            RecorderController audioCont = RecorderController();
            elements.add([
              "MIC",
              MicCustom(
                onTapUse: true,
                indexInList: elements.length,
                audioCont: audioCont,
              ),
            ]);
          } else if (instanceofCreateNewCard.createNewCardElements[index][0] ==
              "ONEANSWER") {
            elements.add(["ONEANSWER", OneAnswer()]);
          }
        }

        if (numberOfEmtpyRequiredFields ==
            instanceofCreateNewCard.createNewCardElements.length) {
          myCoolSnackBar(
              color: kcDangerZone,
              icon: Icons.warning_amber_rounded,
              title: "Uyarı!",
              description:
                  "Şablona eklediğiniz gerekli alanlardan en az birini doldurun.",
              textTheme: Theme.of(context).textTheme);
        } else {
          instanceofCreateNewCard.createNewCardElements.clear();

          emit(CreateNewCardElements(
            createNewCardElements:
                instanceofCreateNewCard.createNewCardElements,
          ));
          Navigator.pop(context);

          // => MAIN PROCESS : ADD NEW CARD TO CARD LIST
          createCard(templateName: templateName, elements: elements);
        }
      } else {
        myCoolSnackBar(
            color: kcDangerZone,
            icon: Icons.warning_amber_rounded,
            title: "Uyarı!",
            description: "Şablona en az bir eleman ekleyin",
            textTheme: Theme.of(context).textTheme);
      }
    } else {
      myCoolSnackBar(
          color: kcDangerZone,
          icon: Icons.warning_amber_rounded,
          title: "Uyarı!",
          description: "Şablon adı olmazsa olmazımızdır",
          textTheme: Theme.of(context).textTheme);
    }
  } // FUNC END : SAVE THE NEW CARD PROPERTIES(TEMPLATE)

  void createCard(
      {required String templateName, required List<List> elements}) {
    Widget newCard = DesignedCard(
      titleName: templateName,
      onTap: () {
        mainCardListInstance.newRegPageElementsList = elements;

        emit(CardListInitial(
            mainCardList: mainCardListInstance.mainCardList,
            newRegPageElementsList:
                mainCardListInstance.newRegPageElementsList));
      },
    );
    mainCardListInstance.mainCardList.add(newCard);
    emit(CardListInitial(
        mainCardList: mainCardListInstance.mainCardList,
        newRegPageElementsList: mainCardListInstance.newRegPageElementsList));
  }

  //CARD ELEMENTS ITEMS REORDER FUNC - Not USed
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

  //MAIN CARD LİST REORDER FUNC -- Not Used
  void onReorderCardList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = mainCardListInstance.mainCardList.removeAt(oldIndex);
    mainCardListInstance.mainCardList.insert(newIndex, item);
    emit(CardListInitial(
        mainCardList: mainCardListInstance.mainCardList,
        newRegPageElementsList: mainCardListInstance.newRegPageElementsList));
  }

  //Create Card List Elements Features
  void emitCardListInitial() => emit(CardListInitial(
      mainCardList: mainCardListInstance.mainCardList,
      newRegPageElementsList: mainCardListInstance.newRegPageElementsList));

  void deleteCardListInitialNewRegList() {
    mainCardListInstance.newRegPageElementsList.clear();
    emit(CardListInitial(
        newRegPageElementsList: mainCardListInstance.newRegPageElementsList,
        mainCardList: mainCardListInstance.mainCardList));
  }

  //Create New Card Elements Features
  void emitcreateNewCardElements() => emit(CreateNewCardElements(
      createNewCardElements: instanceofCreateNewCard.createNewCardElements));

  void deletecreateNewCardElements() {
    instanceofCreateNewCard.createNewCardElements.clear();
    emit(CreateNewCardElements(
        createNewCardElements: instanceofCreateNewCard.createNewCardElements));
  }
}

abstract class CardListState {}

class CardListInitial extends CardListState {
  final List<Widget> mainCardList;
  List<List> newRegPageElementsList;

  CardListInitial(
      {required this.mainCardList, required this.newRegPageElementsList});
}

class CreateNewCardElements extends CardListState {
  final List<List> createNewCardElements;

  CreateNewCardElements({required this.createNewCardElements});
}
