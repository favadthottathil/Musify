import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScanMusicProvider extends ChangeNotifier {
  bool startscan = false;

  bool changeUi = false;

  final OnAudioQuery audioQuery = OnAudioQuery();

  int allsong = 0;

  Future<void> fetchSongs() async {
    final List<SongModel> songs = await audioQuery.querySongs();

    allsong = songs.length;
    notifyListeners();
  }

  void startScan() async {
    startscan = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 4));
    await fetchSongs();
    changeUi = true;
    notifyListeners();
  }
}
