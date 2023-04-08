import 'package:flutter/material.dart';
import 'package:music_application/most_played/most_played.dart';
import 'package:music_application/screens/last_added.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/last_added.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/most_played.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/recently_played.dart';
import 'package:music_application/screens/recentlyplayed_all.dart';
import 'package:music_application/widgets/mainscreen_widgets/name_button.dart';
import 'package:sizer/sizer.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: SizedBox(
              height: 4.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NameHome(name: 'Recently Played'),
                  OutLineButton(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecentlyPlayedAll(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: mediaQuery.size.height * 0.2,
            child: RecentlyPlayed(),
          ),
          SizedBox(height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: SizedBox(
              height: 4.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NameHome(name: 'Mostly Played'),
                  OutLineButton(
                    onpressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MostlyPlayedAll(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: 25.h,
            child: MostPlayed(),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: SizedBox(
              height: 3.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const NameHome(name: 'Last Added'),
                  OutLineButton(
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LastAddedSongs(),
                          ));
                    },
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),
          SizedBox(
            height: mediaQuery.size.height * 0.2,
            child: LastAdded(),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
