import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentProvider extends ChangeNotifier {
  List<SongModel> recentSongsNotifier = [];
   List<dynamic> recentlyPlayed = [];

   Future<void> addRecent(item) async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    await recentDb.add(item);
    getRecent();
    notifyListeners();
  }

   Future<void> getRecent() async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    recentlyPlayed = recentDb.values.toList();
    displayRecents();
    notifyListeners();
  }

   Future<void> displayRecents() async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    final recentSongs = recentDb.values.toList();
    recentSongsNotifier.clear();
    recentlyPlayed.clear();
    for (int i = 0; i < recentSongs.length; i++) {
      for (int j = 0; j < startsongs.length; j++) {
        if (recentSongs[i] == startsongs[j].id) {
          recentSongsNotifier.add(startsongs[j]);
          recentlyPlayed.add(startsongs[j]);
          
        }
      }
    }
  }
}
