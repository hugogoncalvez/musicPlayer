import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:provider/provider.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/helpers/size.dart';

import 'package:music_player/src/widgets/custom_app_bar.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //heigth = 820.57
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.height * 0.65,
            decoration: fondoGradiente(context),
            child: Column(
              children: const [
                CustomAppBar(),
                ImagenDiscoDuracion(),
                TituloBotonPlay(),
              ],
            ),
          ),
          const Expanded(child: Lyrics())
        ],
      )),
    );
  }

  BoxDecoration fondoGradiente(BuildContext context) {
    return BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.center,
            colors: [Color(0xff33333E), Color(0xff201E28)]),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(context.height * 0.07)));
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return ListWheelScrollView(
        physics: const BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics
            .map((linea) => Text(linea,
                style: TextStyle(
                    fontSize: context.height * 0.0244,
                    color: Colors.white.withOpacity(0.6))))
            .toList() // Lista de Widgets !!!!!
        );
  }
}

class TituloBotonPlay extends StatefulWidget {
  const TituloBotonPlay({
    Key? key,
  }) : super(key: key);

  @override
  State<TituloBotonPlay> createState() => _TituloBotonPlayState();
}

class _TituloBotonPlayState extends State<TituloBotonPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController animationController;

  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio!.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: context.height * 0.035, vertical: context.height * 0.035),
      child: Row(
        children: [
          Column(
            children: [
              Text('Far Away',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: context.height * 0.04)),
              Text('-Breaking Benjamin-',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: context.height * 0.019))
            ],
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: () {
              final audioPlayerModel =
                  Provider.of<AudioPlayerModel>(context, listen: false);
              if (isPlaying) {
                animationController.reverse();
                isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                animationController.forward();
                isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            backgroundColor: const Color(0xffF8CB51),
            child: AnimatedIcon(
                icon: AnimatedIcons.play_pause, progress: animationController),
          )
        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [ImagenDisco(), Duracion()],
    );
  }
}

class Duracion extends StatelessWidget {
  const Duracion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final estilo = TextStyle(color: Colors.white.withOpacity(0.5));
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    final porcentaje = audioPlayerModel.porcentaje;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.height * 0.076),
      child: Column(
        children: [
          Text(audioPlayerModel.songTotalDuration, style: estilo),
          SizedBox(height: context.height * 0.01),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  width: context.height * 0.005,
                  height: context.height * 0.25,
                  color: const Color(0xff37353E)),
              Container(
                  width: context.height * 0.004,
                  height: (context.height * 0.15) * porcentaje,
                  color: const Color(0xffDDDDDE)),
            ],
          ),
          SizedBox(height: context.height * 0.01),
          Text(
            audioPlayerModel.currentSecond,
            style: estilo,
          ),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: context.height * 0.05,
              horizontal: context.height * 0.03),
          padding: EdgeInsets.all(context.height * 0.0244),
          width: context.height * 0.2467,
          height: context.height * 0.2467,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [Color(0xff403F48), Color(0xff201E28)]),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(context.height * 0.2),
              child: SpinPerfect(
                  manualTrigger: true,
                  controller: (animationController) =>
                      audioPlayerModel.controller = animationController,
                  duration: const Duration(seconds: 10),
                  infinite: true,
                  child: Image.asset('assets/aurora.jpg'))),
        ),
        Container(
          width: context.height * 0.03,
          height: context.height * 0.03,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xff929D9E)),
        ),
        Container(
          width: context.height * 0.02,
          height: context.height * 0.02,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        ),
      ],
    );
  }
}
