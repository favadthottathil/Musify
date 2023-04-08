// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:music_application/DB/model_db.dart';
// import 'package:music_application/screens/splash/screen.dart';

// class PlaylistDb extends ChangeNotifier {
//   static ValueNotifier<List<SongsDB>> playlistNotifier = ValueNotifier([]);

//   static final playlist = Hive.box<SongsDB>('playlist');

//   static Future<void> addPlaylist(SongsDB value) async {
//     final playlistDb = Hive.box<SongsDB>('playlist');
//     await playlistDb.add(value);
//     playlistNotifier.value.add(value);
//   }

//   static Future<void> getplaylist() async {
//     final playlistDb = Hive.box<SongsDB>('playlist');
//     playlistNotifier.value.clear();
//     playlistNotifier.value.addAll(playlistDb.values);

//     playlistNotifier.notifyListeners();
//   }

//   static Future<void> deletePlaylist(int index) async {
//     final playlistDb = Hive.box<SongsDB>('playlist');
//     await playlistDb.deleteAt(index);
//     getplaylist();
//   }

//   static Future<void> editlist(int index, SongsDB value) async {
//     final playlistDb = Hive.box<SongsDB>('playlist');
//     await playlistDb.putAt(index, value);
//     getplaylist();
//   }

//   static Future<void> reset(context) async {
//     final playlistdb = Hive.box<SongsDB>('playlist');

//     final favorites = Hive.box<int>('Favorite');

//     final recent = Hive.box('recentSongNotifier');

//     final mostly = Hive.box('MostSongNotifier');

//     await playlistdb.clear();

//     await favorites.clear();

//     await recent.clear();

//     await mostly.clear();

//     Navigator.of(context).pushReplacement(MaterialPageRoute(
//       builder: (context) => const Splash(),
//     ));
//   }
// }
