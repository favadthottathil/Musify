import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';

class NowPlayingProvider extends ChangeNotifier {
  Duration duration = const Duration();

  Duration position = const Duration();

  bool firstsong = false;

  bool lastsong = false;

  int large = 0;

  bool songIsPlaying = true;

  // List<AudioSource> songList = [];
  int currentindex = 0;

  void inistate(count) {
    GetAllSongController.audioPlayer.currentIndexStream.listen(
      (index) {
        if (index != null) {
          GetAllSongController.CurrentIndexes = index;
          large = count - 1;
          currentindex = index;
          index == 0 ? firstsong = true : firstsong = false;
          index == large ? lastsong = true : lastsong = false;
        }
      },
    );
  }

  // setDuration(Duration d) {
  //   duration = d;
  // }

  setduration(value) {
    changeduration(value.toInt());
    value = value;
  }

  void changeduration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }

  void playsong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      duration = d!;

      notifyListeners();
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      position = p;

      notifyListeners();
    });
  }

  shuffleOff() {
    GetAllSongController.audioPlayer.setShuffleModeEnabled(true);
  }

  shuffleOn() {
    GetAllSongController.audioPlayer.setShuffleModeEnabled(false);
  }

  songPause() {
    GetAllSongController.audioPlayer.pause();
  }

  songPlay() {
    GetAllSongController.audioPlayer.play();
  }

  bool isPlaying() {
    notifyListeners();

    return songIsPlaying;
  }

  void playPause() {
    songIsPlaying = !songIsPlaying;
  }
}
