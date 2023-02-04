import 'package:flutter/material.dart';

import 'package:music_application/screens/playlist.dart';

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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1516916759473-600c07bc12d4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
                      ),
                      fit: BoxFit.fitHeight),
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
        //           ),
      },
    );
  }
}
