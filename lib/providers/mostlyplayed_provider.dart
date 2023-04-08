import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedProvider with ChangeNotifier {
  List<SongModel> mostPlayedSongsNotifier = [];

  List<dynamic> mostlyPlayed = [];

  Future<void> addMostlyPlayed(item) async {
    final recentDb = await Hive.openBox('MostSongNotifier');
    await recentDb.add(item);

    getMostlyPlayed();
    notifyListeners();
  }

  Future<void> getMostlyPlayed() async {
    final recentDb = await Hive.openBox('MostSongNotifier');
    mostlyPlayed = recentDb.values.toList();

    displaymostly();
    notifyListeners();
  }

  Future<List> displaymostly() async {
    final mostlydb = await Hive.openBox('MostSongNotifier');
    final mostlySongs = mostlydb.values.toList();
    mostPlayedSongsNotifier.clear();
    int counter = 0;

    for (var i = 0; i < mostlySongs.length; i++) {
      for (var k = 0; k < mostlySongs.length; k++) {
        if (mostlySongs[i] == mostlySongs[k]) {
          counter++;
        }
      }
      if (counter > 2) {
        for (var l = 0; l < startsongs.length; l++) {
          if (mostlySongs[i] == startsongs[l].id) {
            mostPlayedSongsNotifier.add(startsongs[l]);
            mostlyPlayed.add(startsongs[l]);
          }
        }
        counter = 0;
      }
    }

    return mostPlayedSongsNotifier;
  }
}
