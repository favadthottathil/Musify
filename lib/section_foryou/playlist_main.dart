import 'package:flutter/material.dart';

import 'package:music_application/screens/playlist.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';

List playlistImg = [
  'Assets/img/butter.jpg',
  'Assets/img/austin-neill-hgO1wFPXl3I-unsplash.jpg',
  'Assets/img/tijs-van-leur-Qnlp3FCO2vc-unsplash.jpg',
  'Assets/img/butter.jpg'
];

class PlayListMain extends StatelessWidget {
  const PlayListMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Playlist(),
                ));
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(playlistImg[index]), fit: BoxFit.fitHeight),
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'clear mind',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Instrumental',
                    style: TextStyle(color: Colors.white54, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
