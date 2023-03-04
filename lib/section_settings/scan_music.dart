import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:music_application/widgets/scan_success.dart';

class ScanMusic extends StatefulWidget {
  const ScanMusic({super.key});

  @override
  State<ScanMusic> createState() => _ScanMusicState();
}

class _ScanMusicState extends State<ScanMusic> {
  bool startscan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Scan music'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          startscan
              ? Center(
                  child: Lottie.asset(
                    'animation/99946-searching.json',
                    height: 250,
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 300),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  startscan = true;
                });
                scanSuccess();
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange[900],
                ),
                child: Center(
                  child: startscan
                      ? const Text(
                          'SCANNING....',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Itim',
                          ),
                        )
                      : const Text(
                          'SCAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Itim',
                          ),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  scanSuccess() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScanSuccess(),
        ));
  }
}
