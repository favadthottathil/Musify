import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';

class SleepTimer extends StatefulWidget {
  const SleepTimer({super.key});

  @override
  State<SleepTimer> createState() => _SleepTimerState();
}

class _SleepTimerState extends State<SleepTimer> {
  int sleepTimerDuraction = 0;

  int duration = 0;

  Timer? sleepTimer;

  // handleDuractionChanged(double value) {
  //   setState(() {
  //     duration = value.toInt();
  //   });
  // }

  // void handleSubmit() {
  //   Navigator.of(context).pop(duration);
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text(
        'Set Sleep Timer',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Select duration',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 20),
          Slider(
            value: duration.toDouble(),
            min: 0,
            max: 60,
            onChanged: (value) {
              setState(() {
                duration = value.toInt();
              });
            },
          ),
          Text(
            '$duration minutes',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
            onPressed: () {
              if (duration > 0) {
                startsSleepTimer(duration);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                    behavior: SnackBarBehavior.floating,
                    content: Center(
                      child: Text(
                        'Set Timer To $duration Minutes',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 84, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                );
              }else{

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                    behavior: SnackBarBehavior.floating,
                    content: const Center(
                      child: Text(
                        'Timer Off',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 84, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                );




              }
              Navigator.pop(context);
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  void startsSleepTimer(int duration) {
    // cancel existing sleep timer

    sleepTimer?.cancel();

    // Start a new sleep timer with the specified duraction

    sleepTimer = Timer(Duration(minutes: duration), () {
      // pause the music and reset the sleep timer when it expires

      GetAllSongController.audioPlayer.pause();

      resetSleepTimer();
    });
    setState(() {
      sleepTimerDuraction = duration;
    });
  }

  resetSleepTimer() {
    // cancel the existing sleep timer

    sleepTimer?.cancel();

    sleepTimer = null;

    setState(() {
      sleepTimerDuraction = 0;
    });
  }
}
