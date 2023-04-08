import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider with ChangeNotifier {
  List<SongModel> allsongs = [];
  List<SongModel> foundSongs = [];

  final audioQuery = OnAudioQuery();

  void songsLoading() async {
    allsongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    foundSongs = allsongs;

    notifyListeners();
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where(
            (element) => element.displayNameWOExt.trim().contains(enteredText.trim()),
          )
          .toList();
    }

    foundSongs = results;
    notifyListeners();
  }
}
