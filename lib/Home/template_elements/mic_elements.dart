import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/shared/helpers.widget.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class MicCustom extends StatelessWidget {
  const MicCustom(
      {super.key,
      this.onTapUse = false,
      required this.indexInList,
      required this.audioCont});

  final bool onTapUse;
  final int indexInList;
  final RecorderController audioCont;

  // AUDIO RECORD FUNC
  void audioRecord({required BuildContext context}) async {
    final PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      myCoolSnackBar(
          color: kcDangerZone,
          description: "Ayarlardan mikrofon iznini açmalısınız.",
          title: "Uyarı!",
          icon: Icons.warning_amber_rounded,
          // ignore: use_build_context_synchronously
          textTheme: Theme.of(context).textTheme);
    }

    await audioCont.record();
    updateAudio(audioCont, context);
  }

  void audioStop(BuildContext context) async {
    await audioCont.pause();
    updateAudio(audioCont, context);
  }

  void updateAudio(RecorderController audioCont, BuildContext context) {
    context
        .read<CardListCubit>()
        .mainCardListInstance
        .newRegPageElementsList[indexInList]
        .insert(2, audioCont);
    context.read<CardListCubit>().emitCardListInitial();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<CardListCubit, CardListState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: DottedBorder(
            strokeCap: StrokeCap.round,
            radius: const Radius.circular(20),
            dashPattern: const [10, 15],
            color: kcParisGreen,
            borderPadding: const EdgeInsets.symmetric(horizontal: 20),
            borderType: BorderType.RRect,
            strokeWidth: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: kcParisGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              height: height * 0.08,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  audioCont.isRecording ||
                          (state is CardListInitial &&
                              state.newRegPageElementsList[indexInList]
                                      .length ==
                                  3)
                      ? AudioWaveforms(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.04),
                          size: Size(width * 0.6, height * 0.06),
                          recorderController: context
                              .read<CardListCubit>()
                              .mainCardListInstance
                              .newRegPageElementsList[indexInList][2],
                          enableGesture: true,
                          waveStyle: const WaveStyle(
                            durationLinesColor: kcwhite54,
                            waveColor: Colors.white,
                            showDurationLabel: true,
                            spacing: 5.0,
                            showBottom: true,
                            extendWaveform: true,
                            showMiddleLine: false,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: width * 0.27),
                          child: Text(
                            "Ses Kaydedin",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: kcwhite54),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                      onPressed: onTapUse
                          ? () async {
                              if (audioCont.isRecording) {
                                audioStop(context);
                              } else {
                                audioRecord(context: context);
                              }
                            }
                          : () {
                              myCoolSnackBar(
                                  color: kcDangerZone,
                                  description:
                                      "Şablon ekranında ses kaydı alınamaz.",
                                  title: "Uyarı!",
                                  icon: Icons.warning_amber_rounded,
                                  // ignore: use_build_context_synchronously
                                  textTheme: Theme.of(context).textTheme);
                            },
                      backgroundColor:
                          onTapUse ? kcMediumGreyPalladium : kcwhite54,
                      foregroundColor: onTapUse ? kcParisGreen : kcblack38,
                      child: const Icon(Icons.mic_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
