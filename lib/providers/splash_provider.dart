import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music_application/mainScreen/main_screen.dart';

class SplashScreenProvider extends ChangeNotifier {
  splashInit(context) {
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      ),
    );
    notifyListeners();
  }
}
