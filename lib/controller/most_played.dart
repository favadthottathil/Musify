import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedfunctions extends ChangeNotifier {
  static final mostplayedNotifier = ValueNotifier<List<SongModel>>([]);
  static List<dynamic> playCounts = [];

  static Future<void> addplayCount(SongModel item) async {
    final mostPlayeddatabase = await Hive.openBox('mostPlayedSongsNotifier');
    int? playCount = mostPlayeddatabase.get(item.id);

    if (playCount == null) {
      playCount = 0;
    }

    playCount++;

    mostPlayeddatabase.put(item.id, playCount);

    getMostd();
  }

  static Future<void> getMostd() async {
    final mostplayeddatabase = await Hive.openBox('mostPlayedSongsNotifier');
    final songItems = startSongs.where(
      (song) => mostplayeddatabase.containsKey(song.id),
    );

    final tempMostPlayed = songItems.toList();

    tempMostPlayed.sort((a, b) {
      final aPlaycount = mostplayeddatabase.get(a.id) as int;

      final bPlaycount = mostplayeddatabase.get(b.id) as int;

      return bPlaycount.compareTo(aPlaycount);
    });
    mostplayedNotifier.value = List.from(tempMostPlayed);
  }

  // static Future<void> showMostPlayed() async {
  //   final mostplayedDatabase = await Hive.openBox('mostPlayedSongsNotifier');
  //   final mostplayedSongItems = mostplayedDatabase.toMap().entries.toList();
  //   final tempMostPlayed = <Map<String, dynamic>>[];
  //   for (final song in mostplayedSongItems) {
  //     if (tempMostPlayed.length >= 10) {
  //       break;
  //     }
  //     for (final startsong in startSongs) {
  //       if (song.key == startsong.id) {
  //         // tempMostPlayed.add('song':startsong, 'playCount': song.value['playCount']);

  //         break;
  //       }
  //     }
  //   }

  //   mostplayedNotifier.value = List.from(tempMostPlayed);
  // }
}
