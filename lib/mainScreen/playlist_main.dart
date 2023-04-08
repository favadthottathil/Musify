import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';

import 'package:music_application/playlist/playlist_single_3.dart';
import 'package:sizer/sizer.dart';

class PlayListMain extends StatelessWidget {
  PlayListMain({super.key});

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
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
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
                                margin: EdgeInsets.all(1.h),
                                height: 20.h,
                                width: 20.h,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('Assets/img/favad.jpg'),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 7.h),
                              child: Center(
                                child: Text(
                                  data.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.sp,
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
