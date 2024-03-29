import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:domedia/controllers/video_folder/videos_recently_played_controller.dart';
import 'package:domedia/view/videos/play_screen/play_video_screen.dart';
import 'package:domedia/view/widgets/thumbnail.dart';
import 'package:provider/provider.dart';

class HomeVideoScreen extends StatefulWidget {
  const HomeVideoScreen({super.key});

  @override
  State<HomeVideoScreen> createState() => _HomeVideoScreenState();
}

class _HomeVideoScreenState extends State<HomeVideoScreen> {
  @override
  void initState() {
    initializeRecentVideos();
    super.initState();
  }

  void initializeRecentVideos() {
    var recentlyVideoProvider = context.read<VideosRecentlyPlayedController>();
    if (!recentlyVideoProvider.isInitiliaz) {
      context
          .read<VideosRecentlyPlayedController>()
          .initializeRecentVideos(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<VideosRecentlyPlayedController>(
        builder: (context, recentVideoProvider, _) {
      if (recentVideoProvider.recentVidoes.isEmpty) {
        return Center(
          child: SizedBox(
            height: size.height * 0.4,
            width: size.width * 0.8,
            child: Image.asset("assets/images/Press pause-rafiki.png"),
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16),
        itemCount: recentVideoProvider.recentVidoes.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                colors: [Color(0xffd1d1d1), Color(0xffe8e8e8)],
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 0.1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.only(left: 8, right: 14, top: 8, bottom: 8),
              leading: thumbnail(
                  path: recentVideoProvider.recentVidoes[index].path,
                  hight: 100,
                  width: 100),
              title: Text(
                recentVideoProvider.recentVidoes[index].title,
                style: GoogleFonts.raleway(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              trailing: const Icon(
                IconlyBold.play,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayVideoScreen(
                      paths: recentVideoProvider.recentVidoes
                          .map((e) => e.path,)
                          .toList(),
                      index: index,
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
