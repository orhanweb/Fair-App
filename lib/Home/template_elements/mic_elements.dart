import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fair_app/Home/models/home_templates_cubit.dart';
import 'package:fair_app/shared/const.dart';
import 'package:fair_app/widgets/custom_fab.dart';
import 'package:fair_app/widgets/custom_my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
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
  late Duration duration;
  final sound.FlutterSoundRecorder recording = sound.FlutterSoundRecorder();
  final PlayerController wavescontroller = PlayerController();
  bool isRecorded = false;
  @override
  void initState() {
    super.initState();
    initRecorder();
  }

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

  Future record({required BuildContext context}) async {
    await recording.startRecorder(toFile: "audio");
    setState(() {});
  }

  Future stop() async {
    final String? path = await recording.stopRecorder();

    // final audioFile = File(path!);

    await wavescontroller.preparePlayer(
      path: path!,
      shouldExtractWaveform: true,
      noOfSamples: 100,
      volume: 1.0,
    );

    isRecorded = true;
    setState(() {});
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
          child: !isRecorded
              ? DottedBorder(
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
                            ? StreamBuilder<sound.RecordingDisposition>(
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
                            onPressed: widget.onTapUse
                                ? () async {
                                    if (recording.isRecording) {
                                      stop();
                                    } else {
                                      record(context: context);
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
                            backgroundColor: widget.onTapUse
                                ? kcMediumGreyPalladium
                                : kcwhite54,
                            foregroundColor:
                                widget.onTapUse ? kcParisGreen : kcblack38,
                            child: recording.isRecording
                                ? const Icon(Icons.square)
                                : const Icon(
                                    Icons.mic_outlined,
                                    size: 30,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              // AFTER RECORDING AUDIO
              : DottedBorder(
                  radius: const Radius.circular(20),
                  dashPattern: const [10, 0],
                  color: kcCuriousBlue,
                  borderPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 20,
                  ),
                  borderType: BorderType.RRect,
                  strokeWidth: 5,
                  child: SizedBox(
                    height: height * 0.15,
                    child: Center(
                      child: Column(
                        children: [
                          AudioFileWaveforms(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            size: Size(width * 0.5, height * 0.08),
                            playerController: wavescontroller,
                            enableSeekGesture: true,
                            waveformType: WaveformType.fitWidth,
                            playerWaveStyle: const PlayerWaveStyle(
                                fixedWaveColor: kcCuriousBlue,
                                liveWaveColor: kcParisGreen),
                          ),
                          myfloatingActionButton(
                            icon: wavescontroller.playerState ==
                                    PlayerState.playing
                                ? Icons.square
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
                          )
                        ],
                      ),
                    ),
                  )),
        );
      },
    );
  }
}
