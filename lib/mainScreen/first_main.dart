import 'package:flutter/material.dart';
import 'package:music_application/playlist/all_playlist%20_1.dart';
import 'package:music_application/mainScreen/playlist_main.dart';
import 'package:sizer/sizer.dart';

import '../widgets/mainscreen_widgets/name_button.dart';

class MainFirst extends StatelessWidget {
  const MainFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          child: Text(
            'Musicly',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          height: 4.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameHome(name: 'Playlist'),
                OutLineButton(
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllPlaylist(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 1.h),
        SizedBox(
          height: 26.h,
          child: PlayListMain(),
        ),
      ],
    );
  }
}
