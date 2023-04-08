import 'package:flutter/material.dart';
import 'package:music_application/providers/recentsongs_provider.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/listitle.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecentlyPlayedAll extends StatelessWidget {
  RecentlyPlayedAll({super.key});

  final OnAudioQuery audioQuery = OnAudioQuery();

  static List<SongModel> recentsong = [];

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  // Future init() async {
  //   await RecentController.getRecent();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 1.h),
                  const Text(
                    'Recently played',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              FutureBuilder(
                future: Provider.of<RecentProvider>(context, listen: false).getRecent(),
                builder: (context, item) {
                  return Consumer<RecentProvider>(
                    builder: (BuildContext context, recent, child) {
                      if (recent.recentSongsNotifier.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Recent Songs?',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        );
                      } else {
                        final temp = recent.recentSongsNotifier.reversed.toList();
                        recentsong = temp.toSet().toList();
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
                                  'No Recently Songs!!!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            return Listtiles(
                              songModel: recentsong,
                              isRecent: true,
                              recentLength: recentsong.length > 5 ? 5 : recentsong.length,
                            );
                          },
                        );
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
