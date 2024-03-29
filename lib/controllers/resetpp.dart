import 'package:hive_flutter/hive_flutter.dart';
import 'package:domedia/model/db/dbmodel.dart';
import 'package:domedia/model/db/videodb_model.dart';

class ResetApp {
  static Future resetApp() async {
    final musicDb = Hive.box<int>('FavoriteDB');
    final songPlayListDb = Hive.box<Playersmodel>("SongPlaylistDB");
    final videoDb = Hive.box<String>('VideoFavoriteDB');
    final videoPlaylisdb =
        Hive.box<PlayersVideoPlaylistModel>('VideoplaylistDB');

    await videoDb.clear();
    await songPlayListDb.clear();
    await videoPlaylisdb.clear();
    await musicDb.clear();
  }
}
