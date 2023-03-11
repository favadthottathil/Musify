import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';

import 'package:music_application/screens/playlist/playlist_single_3.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/recently_played.dart';

class PlayListMain extends StatefulWidget {
  const PlayListMain({super.key});

  @override
  State<PlayListMain> createState() => _PlayListMainState();
}

class _PlayListMainState extends State<PlayListMain> {
  bool isrecent = true;
  dynamic recetlength;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
      builder: (context, value, child) {
        return Container(
          child: Hive.box<SongsDB>('playlist').isEmpty
              ? Center(
                  child: Text(
                    'No Playlist',
                    style: TextStyle(color: Colors.white, fontSize: 30.sp),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: isrecent
                      ? value.length > 5
                          ? 5
                          : value.length
                      : value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = value.values.toList()[index];

                    return ValueListenableBuilder(
                      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
                      builder: (context, musiclist, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Playlist(playlist: data, index: index),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.r),
                                height: 140.h,
                                width: 140.h,
                                decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('Assets/img/favad.jpg'),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.r)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30.w),
                              child: Center(
                                child: Text(
                                  data.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
