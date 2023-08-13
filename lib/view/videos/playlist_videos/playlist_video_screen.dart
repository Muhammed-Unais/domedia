import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/video_add_to_playlist.dart';
import 'package:players_app/controllers/video_folder/access_folder/access_video.dart';
import 'package:players_app/controllers/song_and_video_playlistfolder/new_or_edit_playlist.dart';
import 'package:players_app/model/db/videodb_model.dart';
import 'package:players_app/view/videos/playlist_videos/videos_playlist_videos_list.dart';
import 'package:players_app/view/widgets/explore_widgets/favourites_cards.dart';
import 'package:players_app/view/widgets/playlist_scree.dart/playlist_popup.dart';

class VideoPlaylistScreen extends StatelessWidget {
  final int? vindex;
  final bool addedVideosShoworNot;
  const VideoPlaylistScreen(
      {super.key, this.vindex, required this.addedVideosShoworNot});

  // This is the screen of video playlist folder showing and navigate from explore viewmore and allvideo page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Video Playlist"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.playlist_add),
        onPressed: () {
          // ============For Creation and isforVideo============
          NewOrEditPlaylist.newPlaylistAdd(
              titile: "Create Playlist",
              isCreate: true,
              isSong: false,
              context: context);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<PlayersVideoPlaylistModel>('VideoplaylistDB').listenable(),
        builder: (context, videosPlaylist, _) {
          return videosPlaylist.isEmpty
              ? Center(
                  child: Text(
                    "Create Your Playlist",
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    final vidDatas = videosPlaylist.values.toList()[index];
                    final editedExisitVideos = vidDatas.path;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // ===========videoAddingfunction form all videos Vindex from allvideos selected video index===================

                          addedVideosShoworNot == true
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return VideosPlaylistVideoList(
                                        videoPlaylistFoldermodel: vidDatas,
                                        findex: index,
                                      );
                                    },
                                  ),
                                )
                              : VideoAddToPlaylist.videoAddToPlaylist(
                                  accessVideosPath[vindex!], vidDatas, context);
                        },
                        child: FavouritesCards(
                          image:
                              "assets/images/pexels-dmitry-demidov-6764885.jpg",
                          cardtext: vidDatas.name,
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width,
                          change: true,
                          firstIcon: Icons.playlist_add_check_outlined,
                          trailingicons: Icons.more_vert,
                          moreVertPopupicon:
                              //========== For Update and delete and isForVideo================
                              editAndDeleteDialoge(
                            isforSong: false,
                            ctx: context,
                            index: index,
                            test: editedExisitVideos,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: videosPlaylist.length,
                );
        },
      ),
    );
  }
}