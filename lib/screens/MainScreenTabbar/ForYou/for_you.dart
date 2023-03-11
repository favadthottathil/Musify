import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_application/screens/most_played/most_played.dart';
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 30.h,
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
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: const RecentlyPlayed(),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 30.h,
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
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: const MostPlayed(),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SizedBox(
              height: 30.h,
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
          SizedBox(height: 20.h),
          SizedBox(
            height: 180.h,
            child: const LastAdded(),
          ),
        ],
      ),
    );
  }
}
