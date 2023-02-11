import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/recorded_sound.dart';
import 'package:fair_app/Core/Constants/const.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class MicCustom extends StatefulWidget {
  const MicCustom({
    super.key,
    this.onTapUse = false,
    required this.indexInList,
  });

  final bool onTapUse;
  final int indexInList;

  @override
  State<MicCustom> createState() => _MicCustomState();
}

class _MicCustomState extends State<MicCustom> {
  // VARIABLES ///////////
  late Duration duration;
  final FlutterSoundRecorder recording = FlutterSoundRecorder();
  String? recordedPath;

  @override
  void initState() {
    super.initState();
    initRecorder();
  }
  //FUNCTIONS ************

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      myCoolSnackBar(
          color: kcDangerZone,
          description: "Ayarlardan mikrofon iznini açmalısınız.",
          title: "Uyarı!",
          icon: Icons.warning_amber_rounded,
          // ignore: use_build_context_synchronously
          textTheme: Theme.of(context).textTheme);
    }
    await recording.openRecorder();
    recording.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future record() async {
    await recording.startRecorder(toFile: "audio");
    setState(() {});
  }

  Future<void> stop(BuildContext context) async {
    if (duration.inMilliseconds <= 2000) {
      myCoolSnackBar(
          color: kcDangerZone,
          description: "En az iki saniye kayıt alın.",
          title: "Uyarı!",
          icon: Icons.warning_amber_rounded,
          textTheme: Theme.of(context).textTheme);
    } else {
      final String? path = await recording.stopRecorder();
      // ignore: use_build_context_synchronously
      context
          .read<CardListCubit>()
          .mainCardListInstance
          .newRegPageElementsList
          .removeAt(widget.indexInList);

      // ignore: use_build_context_synchronously
      context
          .read<CardListCubit>()
          .mainCardListInstance
          .newRegPageElementsList
          .insert(widget.indexInList, [
        "SOUND",
        RecordedSound(recordedPath: path!, indexInList: widget.indexInList),
        path
      ]);

      // ignore: use_build_context_synchronously
      context.read<CardListCubit>().emitCardListInitial();
    }
  }

  String twoDigits(int seconds) => seconds.toString().padLeft(2, "0");

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
                          recording.isRecording
                              ? StreamBuilder<RecordingDisposition>(
                                  stream: recording.onProgress,
                                  builder: (context, snapshot) {
                                    duration = snapshot.hasData
                                        ? snapshot.data!.duration
                                        : Duration.zero;
                                    final minutes = twoDigits(
                                        duration.inMinutes.remainder(60));
                                    final seconds = twoDigits(
                                        duration.inSeconds.remainder(60));
                                    return Padding(
                                      padding:
                                          EdgeInsets.only(left: width * 0.35),
                                      child: Text(
                                        "$minutes:$seconds",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(color: kcwhite),
                                      ),
                                    );
                                  },
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
                                  tooltip: "Ses Kaydet",
                                  onPressed: widget.onTapUse
                                      ? () async {
                                          if (recording.isRecording) {
                                            await stop(context);
                                          } else {
                                            record();
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
                                              textTheme:
                                                  Theme.of(context).textTheme);
                                        },
                                  backgroundColor: widget.onTapUse
                                      ? kcMediumGreyPalladium
                                      : kcwhite54,
                                  foregroundColor: widget.onTapUse
                                      ? kcParisGreen
                                      : kcblack38,
                                  child: recording.isRecording
                                      ? const Icon(Icons.stop_rounded)
                                      : const Icon(
                                          Icons.mic_outlined,
                                          size: 30,
                                        )))
                        ]))));
      },
    );
  }
}
