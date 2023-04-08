import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/screens/splash/screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListProvider extends ChangeNotifier {
  List<SongsDB> playlistNotifier = [];

  final playlist = Hive.box<SongsDB>('playlist');

  Future<void> addPlaylist(SongsDB value) async {
    final playlistDb = Hive.box<SongsDB>('playlist');
    await playlistDb.add(value);
    playlistNotifier.add(value);
    notifyListeners();
  }

  Future<void> getplaylist() async {
    final playlistDb = Hive.box<SongsDB>('playlist');
    playlistNotifier.clear();
    playlistNotifier.addAll(playlistDb.values);
    notifyListeners();
  }

  Future<void> deletePlaylist(int index) async {
    final playlistDb = Hive.box<SongsDB>('playlist');
    await playlistDb.deleteAt(index);
    getplaylist();
    notifyListeners();
  }

  Future<void> editlist(int index, SongsDB value) async {
    final playlistDb = Hive.box<SongsDB>('playlist');
    await playlistDb.putAt(index, value);
    getplaylist();
    notifyListeners();
  }

  Future<void> reset(context) async {
    final playlistdb = Hive.box<SongsDB>('playlist');

    final favorites = Hive.box<int>('Favorite');

    final recent = Hive.box('recentSongNotifier');

    final mostly = Hive.box('MostSongNotifier');

    await playlistdb.clear();

    await favorites.clear();

    await recent.clear();

    await mostly.clear();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const Splash(),
    ));
    notifyListeners();
  }

  void songAddToPlaylist(SongModel data, playlist, context) {
    playlist.add(data.id);
    // print('songs added to playlsit === ${data.id}');
    final addedToPlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: 250,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song added to Playlist',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(addedToPlaylist);

    notifyListeners();
    // playlistNotifier.addListener(() {});
  }

  void songdeleteFromPlaylist(SongModel data, playlist, context) {
    playlist.deletedata(data.id);
    final removeplaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: 250,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song Removed from Playlist',
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(removeplaylist);

    notifyListeners();
  }
}
