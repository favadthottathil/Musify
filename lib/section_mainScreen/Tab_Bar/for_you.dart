import 'package:flutter/material.dart';
import 'package:music_application/most_played/most_played.dart';

import 'package:music_application/section_foryou/last_added.dart';
import 'package:music_application/section_foryou/most_played.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';
import 'package:music_application/section_recently/recentlyplayed_all.dart';
import 'package:music_application/widgets/mainscreen_widgets/name_button.dart';

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameHome(name: 'Recently Played'),
                OutLineButton(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecentlyPlayedAll(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          height: 145,
          child: RecentlyPlayed(),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameHome(name: 'Mostly Played'),
                OutLineButton(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MostPlayedList(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          height: 200,
          child: MostPlayed(),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameHome(name: 'Last Added'),
                OutLineButton(
                  onpressed: () {},
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(
          height: 145,
          child: LastAdded(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
