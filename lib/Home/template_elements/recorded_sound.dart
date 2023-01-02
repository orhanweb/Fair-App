import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/Home/template_elements/mic_elements.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_fab.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_speech/google_speech.dart';

class RecordedSound extends StatefulWidget {
  const RecordedSound(
      {super.key, required this.recordedPath, required this.indexInList});

  final String recordedPath;
  final int indexInList;
  @override
  State<RecordedSound> createState() => _RecordedSoundState();
}

class _RecordedSoundState extends State<RecordedSound> {
  final TextEditingController controller = TextEditingController();
  final PlayerController wavescontroller = PlayerController();
  Duration? currentDur;
  bool transcribingContiunue = false;

  @override
  void initState() {
    super.initState();
    listenWavesCont();
    Future.delayed(
      Duration.zero,
      () async {
        await wavescontroller.preparePlayer(
          path: widget.recordedPath,
          shouldExtractWaveform: true,
          noOfSamples: const PlayerWaveStyle()
              .getSamplesForWidth(MediaQuery.of(context).size.width * 0.58),
          volume: 1.0,
        );
        currentDur = Duration(milliseconds: wavescontroller.maxDuration);
        setState(() {});
      },
    );
  }

  // FUNCTIONS
  String twoDigits(int seconds) => seconds.toString().padLeft(2, "0");

  Future listenWavesCont() async {
    wavescontroller.onCurrentDurationChanged.listen((newDuration) async {
      final maxDur = await wavescontroller.getDuration(DurationType.max);
      if ((await wavescontroller.getDuration(DurationType.max)) -
              (await wavescontroller.getDuration(DurationType.current)) <=
          400) {
        wavescontroller.seekTo(0);
        wavescontroller.pausePlayer();
      }
      setState(() {
        currentDur = Duration(milliseconds: maxDur - newDuration);
      });
    });
  }

  Future convertToText() async {
    setState(() {
      transcribingContiunue = true;
    });
    final serviceAccount = ServiceAccount.fromString(
        (await rootBundle.loadString('assets/ekin-373009-c3f8b2252a82.json')));
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = RecognitionConfig(
        encoding: AudioEncoding.LINEAR16,
        enableAutomaticPunctuation: true,
        sampleRateHertz: 16000,
        languageCode: 'tr');

    final audiototext = File(widget.recordedPath).readAsBytesSync().toList();
    await speechToText.recognize(config, audiototext).then(
      (value) {
        setState(() {
          controller.text = value.results
              .map((e) => e.alternatives.first.transcript)
              .join("\n");
        });
      },
    ).whenComplete(
      () {
        setState(() {
          if (controller.text.isEmpty) {
            myCoolSnackBar(
                color: kcDangerZone,
                description: "Kelime bulunamadı.",
                title: "Uyarı!",
                icon: Icons.warning_amber_rounded,
                textTheme: Theme.of(context).textTheme);
          }
          transcribingContiunue = false;
        });
      },
    );
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
                radius: const Radius.circular(20),
                dashPattern: const [10, 0],
                color: kcCuriousBlue,
                borderPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                borderType: BorderType.RRect,
                strokeWidth: 5,
                child: SizedBox(
                    height: controller.text.isNotEmpty
                        ? height * 0.5
                        : height * 0.15,
                    child: Center(
                        child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AudioFileWaveforms(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              size: Size(width * 0.6, height * 0.08),
                              playerController: wavescontroller,
                              enableSeekGesture: true,
                              waveformType: WaveformType.fitWidth,
                              playerWaveStyle: const PlayerWaveStyle(
                                  scaleFactor: 200,
                                  fixedWaveColor: kcCuriousBlue,
                                  liveWaveColor: kcParisGreen),
                            ),
                            currentDur == null
                                ? const SizedBox()
                                : Builder(builder: (context) {
                                    final minutes = twoDigits(
                                        currentDur!.inMinutes.remainder(60));
                                    final seconds = twoDigits(
                                        currentDur!.inSeconds.remainder(60));
                                    return Text("$minutes:$seconds",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall);
                                  })
                          ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            myfloatingActionButton(
                              icon: wavescontroller.playerState ==
                                      PlayerState.playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              onPressed: wavescontroller.playerState ==
                                      PlayerState.playing
                                  ? () async {
                                      await wavescontroller.pausePlayer();
                                      setState(() {});
                                    }
                                  : () async {
                                      await wavescontroller.startPlayer();
                                      setState(() {});
                                    },
                            ),
                            FloatingActionButton(
                              onPressed: convertToText,
                              backgroundColor: kcPrimaryCascadeTwilight,
                              child: transcribingContiunue
                                  ? const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2, color: kcwhite))
                                  : const Icon(Icons.text_snippet_rounded),
                            ),
                            myfloatingActionButton(
                              icon: Icons.replay_rounded,
                              onPressed: () {
                                context
                                    .read<CardListCubit>()
                                    .mainCardListInstance
                                    .newRegPageElementsList
                                    .removeAt(widget.indexInList);

                                context
                                    .read<CardListCubit>()
                                    .mainCardListInstance
                                    .newRegPageElementsList
                                    .insert(widget.indexInList, [
                                  "MIC",
                                  MicCustom(
                                    onTapUse: true,
                                    indexInList: widget.indexInList,
                                  ),
                                ]);
                                context
                                    .read<CardListCubit>()
                                    .emitCardListInitial();
                              },
                            )
                          ]),
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
                    ])))));
      },
    );
  }
}
