import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/widgets/recently_played.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayed extends StatefulWidget {
  const MostPlayed({super.key});

  @override
  State<MostPlayed> createState() => _MostPlayedState();
}

class _MostPlayedState extends State<MostPlayed> {
  dynamic mostLength;

  bool isMostplayed = true;

  final OnAudioQuery audioQuery = OnAudioQuery();

  static List<SongModel> mostlySongs = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    await Mostlycontroller.getMostlyPlayed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Mostlycontroller.getMostlyPlayed(),
      builder: (context, snapshot) {
        return ValueListenableBuilder(
          valueListenable: Mostlycontroller.mostPlayedSongsNotifier,
          builder: (context, mostly, child) {
            if (mostly.isEmpty) {
              return Center(
                child: Text(
                  'No Mostly Songs',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              );
            } else {
              final temp = mostly.reversed.toList();
              mostlySongs = temp.toSet().toList();
              return FutureBuilder<List<SongModel>>(
                future: audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (item.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Mostly Songs',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: isMostplayed
                        ? mostlySongs.length > 4
                            ? 4
                            : mostlySongs.length
                        : mostlySongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10.w),
                        height: 100.h,
                        width: 130.w,
                        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: QueryArtworkWidget(
                                  id: mostlySongs[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkHeight: 90.h,
                                  artworkWidth: 90.w,
                                  nullArtworkWidget: Padding(
                                    padding: EdgeInsets.only(left: 7.w, top: 6.h),
                                    child: Icon(
                                      Icons.music_note,
                                      color: Colors.white,
                                      size: 85.sp,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                height: 15.h,
                                width: 100.w,
                                child: Text(
                                  mostlySongs[index].displayNameWOExt,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp, color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
