import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/new_or_edit_playlist.dart';

class SpeedDials extends StatelessWidget {
  const SpeedDials({super.key});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      backgroundColor: Colors.white,
      children: [
        SpeedDialChild(
          label: "Create Video Playlist ",
          child: const Icon(
            Icons.video_collection,
          ),
          onTap: () {
             NewOrEditPlaylist.newPlaylistAdd(
              isSong: false,
              isCreate: true,
              titile: "Create Playlist",
              context: context);
          },
        ),
        SpeedDialChild(
          label: "Create Song Playlist",
          child: const Icon(
            Icons.library_music,
          ),
          onTap: () {
             NewOrEditPlaylist.newPlaylistAdd(
              isSong: true,
              isCreate: true,
              titile: "Create Playlist",
              context: context);
          },
        )
      ],
      child: const Icon(
        Icons.playlist_add,
        color: Colors.black,
      ),
    );
  }
}
// ===========NewPlaylist Adding DialogBox From Playlist Screen==================