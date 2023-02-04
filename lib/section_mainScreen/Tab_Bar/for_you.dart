import 'package:flutter/material.dart';

import 'package:music_application/section_mainScreen/last_added.dart';
import 'package:music_application/section_mainScreen/most_played.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recently Played',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 145,
            child: RecentlyPlayed(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Most Played',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: MostPlayed(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Last Added',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 145,
            child: LastAdded(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
