import 'package:flutter/material.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';

class MostPlayed extends StatelessWidget {
  const MostPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.only(left: 10),
          height: 100,
          width: 130,
          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 90,
                ),
                const SizedBox(height: 18),
                const Text(
                  'Good 4 U',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.headphones_outlined,
                      color: Colors.white54,
                      size: 20,
                    ),
                    SizedBox(width: 3),
                    Text(
                      '5',
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
