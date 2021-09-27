import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool playing = false;
  late AnimationController controller;
  Duration songDuration = const Duration(milliseconds: 0);
  Duration current = const Duration(milliseconds: 0);

  String get songTotalDuration => printDuration(songDuration);
  String get currentSecond => printDuration(current);

  double get porcentaje => (songDuration.inSeconds > 0)
      ? current.inSeconds / songDuration.inSeconds
      : 0;

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  notifyListeners();
}


  // set controller(AnimationController valor) {
  //   _controller = valor;
  // }

  // AnimationController get controller => _controller;