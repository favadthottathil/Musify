import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_application/screens/playlist/all_playlist%20_1.dart';
import 'package:music_application/mainScreen/playlist_main.dart';

import '../widgets/mainscreen_widgets/name_button.dart';

class MainFirst extends StatelessWidget {
  const MainFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        SizedBox(height: 10.h),
        SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameHome(name: 'Playlist'),
                OutLineButton(
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AllPlaylist(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 204.h,
          child: const PlayListMain(),
        ),
      ],
    );
  }
}
