import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';

class SleepTimerProvider extends ChangeNotifier {
  int sleepTimerDuraction = 0;

  int duration = 0;

  Timer? sleepTimer;

  setDuration(int value) {
    duration = value;

    notifyListeners();
  }

  void startSleepTimer() {
    if (duration > 0) {
      // cancel existing sleep timer
      sleepTimer?.cancel();

      // Start a new sleep timer with the specified duration
      sleepTimer = Timer(Duration(minutes: duration), () {
        // pause the music and reset the sleep timer when it expires
        GetAllSongController.audioPlayer.pause();
        resetSleepTimer();
      });
      sleepTimerDuraction = duration;
      notifyListeners();
    }
  }

  resetSleepTimer() {
    // cancel the existing sleep timer

    sleepTimer?.cancel();

    sleepTimer = null;

    sleepTimerDuraction = 0;

    notifyListeners();
  }
}
