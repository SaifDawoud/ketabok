import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ketabok/common.dart';
import 'package:ketabok/style/my_theme.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';

import '../data/models/sura.dart';

class SuraDetails extends StatefulWidget {
  static String routName = '/sura_details';

  //https://equran.id/api/v2/surat/1
  SuraDetails({super.key});

  @override
  State<SuraDetails> createState() => _SuraDetailsState();
}

class _SuraDetailsState extends State<SuraDetails> with WidgetsBindingObserver {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://equran.nos.wjv-1.neo.id/audio-full/Ibrahim-Al-Dossari/001.mp3")));
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    final routArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, Sura>;
    late Sura? sura = routArgus['sura'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset("assets/svgs/arrow_back.svg"),
        ),
        backgroundColor: MyTheme.darkScaffold,
        title: Text("${sura!.namaLatin}",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 265,
                    width: 350,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            stops: [
                              0,
                              .6,
                              1
                            ],
                            colors: [
                              MyTheme.startgradient,
                              MyTheme.middlegradient,
                              MyTheme.endgradient
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                        opacity: 0.06,
                        child: SvgPicture.asset(
                          "assets/svgs/home_quran.svg",
                          width: 345,
                          clipBehavior: Clip.hardEdge,
                        ))),
                Positioned(
                    top: 10,
                    right: 60,
                    child: SvgPicture.asset("assets/svgs/basmalah.svg"))
              ],
            ),
          ),
          SizedBox(height: 60,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display play/pause button and volume/speed sliders.
              ControlButtons(_player),
              // Display seek bar. Using StreamBuilder, this widget rebuilds
              // each time the position, buffered position or duration changes.
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
            ],
          ),
        ],
      ),
      backgroundColor: MyTheme.darkScaffold,
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up,color: Colors.white,),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow,color: Colors.white,),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause,color: Colors.white),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay,color: Colors.white),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
