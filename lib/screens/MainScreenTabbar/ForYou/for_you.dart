import 'package:flutter/material.dart';
import 'package:music_application/most_played/most_played.dart';
import 'package:music_application/screens/last_added.dart';

import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/last_added.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/most_played.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/recently_played.dart';
import 'package:music_application/screens/recentlyplayed_all.dart';
import 'package:music_application/widgets/mainscreen_widgets/name_button.dart';

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      child: Column(
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
          SizedBox(
            height: mediaQuery.size.height * 0.2,
            child: const RecentlyPlayed(),
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
                          builder: (context) => const MostlyPlayedAll(),
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
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LastAddedSongs(),
                          ));
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: mediaQuery.size.height * 0.2,
            child: const LastAdded(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
