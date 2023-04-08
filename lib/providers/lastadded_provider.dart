import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LastAddedProvider extends ChangeNotifier {
  List<SongModel> lastPlayedSongs = [];

  List<SongModel> allsongs = [];

  Future<void> songsLastPlayed() async {
    OnAudioQuery audioQuery = OnAudioQuery();

    lastPlayedSongs = await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED);

    allsongs = lastPlayedSongs;
  }
}
