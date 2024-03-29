import 'package:flutter/material.dart';
import 'package:domedia/view/widgets/playing%20music%20page/play_music_buttons.dart';

class PlayPausebutton extends StatelessWidget {
  const PlayPausebutton({super.key, required this.isPlaying, required this.function});

  final bool isPlaying;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return PlaySongButtons(
      width: 60,
      hight: 60,
      icons: IconButton(
        onPressed: function,
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.black,
        ),
        tooltip: isPlaying ? "Pause" : "Play",
      ),
    );
  }
}
