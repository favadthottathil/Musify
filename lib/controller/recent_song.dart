import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentController extends ChangeNotifier {
  static ValueNotifier<List<SongModel>> recentSongsNotifier = ValueNotifier([]);
  static List<dynamic> recentlyPlayed = [];

  static Future<void> addRecent(item) async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    await recentDb.add(item);
    getRecent();
    recentSongsNotifier.notifyListeners();
  }

  static Future<void> getRecent() async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    recentlyPlayed = recentDb.values.toList();
    displayRecents();
    recentSongsNotifier.notifyListeners();
  }

  static Future<void> displayRecents() async {
    final recentDb = await Hive.openBox('recentSongNotifier');
    final recentSongs = recentDb.values.toList();
    recentSongsNotifier.value.clear();
    recentlyPlayed.clear();
    for (int i = 0; i < recentSongs.length; i++) {
      for (int j = 0; j < allsongs.length; j++) {
        if (recentSongs[i] == allsongs[j].id) {
          recentSongsNotifier.value.add(allsongs[j]);
          recentlyPlayed.add(allsongs[j]);
        }
      }
    }
  }
}
