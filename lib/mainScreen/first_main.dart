import 'package:flutter/material.dart';
import 'package:music_application/screens/playlist/all_playlist%20_1.dart';
import 'package:music_application/mainScreen/playlist_main.dart';

import '../widgets/mainscreen_widgets/name_button.dart';

class MainFirst extends StatelessWidget {
  const MainFirst({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Musicly',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NameHome(name: 'Playlist'),
                  OutLineButton(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllPlaylist(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 200,
            child: PlayListMain(),
          ),
        ],
      ),
    );
  }
}
