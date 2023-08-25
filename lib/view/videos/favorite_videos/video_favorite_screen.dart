import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:players_app/controllers/video_folder/video_favorite_db.dart';
import 'package:players_app/view/videos/play_screen/play_video_screen.dart';
import 'package:players_app/view/widgets/model_widget/listtale_songs_model.dart';
import 'package:players_app/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

class VideoFavoriteScreen extends StatelessWidget {
  const VideoFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ========================================
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Videos",
          style: GoogleFonts.raleway(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Consumer<VideoFavoriteDb>(
        builder: (context, videoFavorites, child) {
          final itemsOfVFavdb = videoFavorites.videoFavoriteDb;
          return videoFavorites.videoFavoriteDb.isEmpty
              ? const Center(
                  child: Text(
                    "No Favorites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.builder(
                    itemCount: itemsOfVFavdb.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListtaleModelVidSong(
                          leading: thumbnail(
                              path: itemsOfVFavdb[index].path,
                              hight: 130,
                              width: 130),
                          title: itemsOfVFavdb[index].title,
                          trailingOne: IconButton(
                            onPressed: () =>
                                videoFavorites.favouriteAddandDelete(
                              path: itemsOfVFavdb[index].path,
                              title: itemsOfVFavdb[index].title,
                            ),
                            icon: const Icon(Icons.delete),
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlayVideoScreen(
                                  paths: itemsOfVFavdb.map((e) => e.path).toList(),
                                  index: index,
                                
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
