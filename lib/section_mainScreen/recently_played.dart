import 'package:flutter/material.dart';

import 'package:music_application/screens/now_playing.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const NowPlaying(songModel: items,),
                // ));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1596300919357-77dbd158c7b8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80'), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Good 4 U', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(
              'Olivia Rodrigo',
              style: TextStyle(color: Colors.white30, fontSize: 10),
            )
          ],
        );
      },
    );
  }
}
