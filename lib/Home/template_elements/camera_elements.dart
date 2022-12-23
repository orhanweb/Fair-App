import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class CameraElements extends StatelessWidget {
  CameraElements({
    super.key,
    this.onTapUse = false,
    required this.indexInList,
  });

  final bool onTapUse;
  final int indexInList;
  TextEditingController controller = TextEditingController();

  Future<File?> pickImage(
      {required ImageSource source, required BuildContext context}) async {
    try {
      final img = await ImagePicker().pickImage(source: source);
      if (img == null) return null;
      File? image = File(img.path);
      return image;
    } on PlatformException catch (_) {
      myCoolSnackBar(
        icon: Icons.warning_amber_rounded,
        color: kcDangerZone,
        title: "Uyarı!",
        description: "Bir şeyler ters gitti tekrar deneyin.",
        textTheme: Theme.of(context).textTheme,
      );
    }
    return null;
  }

  Future croppedImage({required File imagesource}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imagesource.path);
    if (croppedImage == null) return imagesource.path;

    File? image = File(croppedImage.path);

    return image;
  }

  Future<String> getTextOnImage({required File image}) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;

    return text;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return SizedBox(
          height: controller.text.isNotEmpty ? height * 0.5 : height * 0.3,
          child: (state is CreateNewCardElements &&
                      state.createNewCardElements[indexInList][2] == null) ||
                  (state is CardListInitial &&
                      state.newRegPageElementsList[indexInList][2] == null)
              ? // RUN IF HAVE NOT IMAGE
              InkWell(
                  onTap: onTapUse
                      ? () async {
                          File? imagePicked = await pickImage(
                              source: ImageSource.camera, context: context);
                          // ignore: use_build_context_synchronously
                          context
                              .read<CardListCubit>()
                              .mainCardListInstance
                              .newRegPageElementsList[indexInList]
                              .insert(2, imagePicked);
                          // ignore: use_build_context_synchronously
                          context.read<CardListCubit>().emitCardListInitial();
                        }
                      : () {
                          myCoolSnackBar(
                              color: kcDangerZone,
                              description:
                                  "Şablon ekranında fotoğraf çekilemez.",
                              title: "Uyarı!",
                              icon: Icons.warning_amber_rounded,
                              textTheme: Theme.of(context).textTheme);
                        },
                  child: DottedBorder(
                      strokeCap: StrokeCap.round,
                      radius: const Radius.circular(20),
                      dashPattern: const [10, 15],
                      color: kcParisGreen,
                      borderPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 25,
                      ),
                      borderType: BorderType.RRect,
                      strokeWidth: 5,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 35,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: kcParisGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.photo_camera,
                            size: 30,
                          )))),
                )
              // RUN IF HAVE IMAGE
              : DottedBorder(
                  radius: const Radius.circular(20),
                  dashPattern: const [10, 0],
                  color: kcCuriousBlue,
                  borderPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  borderType: BorderType.RRect,
                  strokeWidth: 5,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: height * 0.23,
                            margin: const EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 35,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Image.file(
                                  context
                                      .read<CardListCubit>()
                                      .mainCardListInstance
                                      .newRegPageElementsList[indexInList][2],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          controller.text.isNotEmpty
                              ? SizedBox(
                                  width: width * 0.8,
                                  child: TextField(
                                    decoration:
                                        customhomeinputstyle("Yazı Formatı"),
                                    maxLines: 5,
                                    controller: controller,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(
                              onPressed: () async {
                                File? imageCropped = await croppedImage(
                                    imagesource: context
                                            .read<CardListCubit>()
                                            .mainCardListInstance
                                            .newRegPageElementsList[indexInList]
                                        [2]);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<CardListCubit>()
                                    .mainCardListInstance
                                    .newRegPageElementsList[indexInList]
                                    .removeAt(2);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<CardListCubit>()
                                    .mainCardListInstance
                                    .newRegPageElementsList[indexInList]
                                    .insert(2, imageCropped);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<CardListCubit>()
                                    .emitCardListInitial();
                              },
                              child: const Icon(Icons.crop_outlined),
                            ),
                            FloatingActionButton(
                              onPressed: () async {
                                final String textOnImage = await getTextOnImage(
                                    image: context
                                            .read<CardListCubit>()
                                            .mainCardListInstance
                                            .newRegPageElementsList[indexInList]
                                        [2]);

                                controller.text = textOnImage;
                                // // ignore: use_build_context_synchronously
                                // context
                                //     .read<CardListCubit>()
                                //     .mainCardListInstance
                                //     .newRegPageElementsList[indexInList]
                                //     .insert(3, textOnImage);
                                // // ignore: use_build_context_synchronously
                                // context
                                //     .read<CardListCubit>()
                                //     .mainCardListInstance
                                //     .newRegPageElementsList[indexInList]
                                //     .removeAt(4);
                                // // ignore: use_build_context_synchronously
                                // context
                                //     .read<CardListCubit>()
                                //     .emitCardListInitial();
                                //print(textOnImage);
                              },
                              child: const Icon(Icons.text_snippet_outlined),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
