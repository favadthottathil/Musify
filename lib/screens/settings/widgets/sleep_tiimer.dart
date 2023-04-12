import 'package:flutter/material.dart';
import 'package:music_application/providers/sleeptimer_provider.dart';
import 'package:provider/provider.dart';

class SleepTimer extends StatelessWidget {
  const SleepTimer({super.key});


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
          Consumer<SleepTimerProvider>(builder: (context, timeprovider, child) {
            return Slider(
              value: timeprovider.duration.toDouble(),
              min: 0,
              max: 60,
              onChanged: (value) {
                timeprovider.setDuration(value.toInt());
              },
            );
          }),
          Consumer<SleepTimerProvider>(builder: (context, value, child) {
            return Text(
              '${value.duration} minutes',
              style: const TextStyle(color: Colors.white),
            );
          })
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
              Provider.of<SleepTimerProvider>(context, listen: false).startSleepTimer();
              int duration = Provider.of<SleepTimerProvider>(context, listen: false).duration;
              if (duration > 0) {
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
              } else {
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
}
