import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:lottie/lottie.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/screens/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScanSuccess extends StatefulWidget {
  const ScanSuccess({super.key});

  @override
  State<ScanSuccess> createState() => _ScanSuccessState();
}

class _ScanSuccessState extends State<ScanSuccess> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  int allsong = 0;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Settings(),
                ));
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Scan Music'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Center(
            child: Lottie.asset(
              'animation/1708-success.json',
              height: 300,
              repeat: false,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$allsong ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 35, 244, 45),
                      fontSize: 25,
                    ),
                  ),
                  const TextSpan(
                    text: 'Songs added to Music Player',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  )
                ],
              ),
            ),
          )
          // Text(
          //   '$allsong songs added to Music Player',
          //   style: TextStyle(color: Colors.white, fontSize: 25),
          // )
        ],
      ),
    );
  }

  Future<void> fetchSongs() async {
    final List<SongModel> songs = await audioQuery.querySongs();

    setState(() {
      allsong = songs.length;
    });
  }
}
