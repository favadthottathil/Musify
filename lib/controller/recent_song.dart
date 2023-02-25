import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentController extends ChangeNotifier {
  static final recentSongsNotifier = ValueNotifier<List<SongModel>>([]);
  static List<dynamic> recently = [];
  static SongModel? prevsong;
  static bool isSame = false;

  static Future<void> addRecent(item) async {
    final recentdatabase = await Hive.openBox('recentSongNotifier');
    await recentdatabase.add(item);
    getRecent();
  }

  static Future<void> getRecent() async {
    final recentdb = await Hive.openBox('recentSongNotifier');
    recently = recentdb.values.toList();
    recently.clear();
    recently.addAll(recentdb.values.toList());
    await showrecent();
  }

  static Future<void> showrecent() async {
    final recentdatabase = await Hive.openBox('recentSongNotifier');
    final recentSongItems = recentdatabase.values.toList();
    final tempRecent = <SongModel>[];
    for (final recentsongitem in recentSongItems) {
      final startsong = startSongs.firstWhere(
        (song) => song.id == recentsongitem,
      );

      // if (startsong != null) {
      //   if (prevsong != null && prevsong!.id == startsong.id) {
      //     isSame = true;
      //   } else {
      //     isSame = false;
      //   }

      //   if (!isSame) {
      //     tempRecent.add(startsong);
      //   }

      //   tempRecent.add(startsong);
      //   prevsong = startsong;
      // }

      tempRecent.add(startsong);

      // for (final startsong in startSongs) {
      //   if (!recently.contains(startsong) && recentsongitem == startsong.id) {
      //     tempRecent.add(startsong);
      //   }
      // }
    }
    recentSongsNotifier.value = List.from(tempRecent);
  }
}
