import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_application/providers/mostlyplayed_provider.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/listitle.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MostlyPlayedAll extends StatelessWidget {
  MostlyPlayedAll({super.key});

  final OnAudioQuery audioQuery = OnAudioQuery();

  static List<SongModel> mostlySongs = [];

  // @override
  // void initState() {
  //   init();
  //   super.initState();
  // }

  // Future init() async {
  //   await Mostlycontroller.getMostlyPlayed();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MostlyPlayedProvider>(context, listen: false).getMostlyPlayed();
      log('${Provider.of<MostlyPlayedProvider>(context, listen: false).mostPlayedSongsNotifier.length}');
    });
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
                    'Mostly played',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              FutureBuilder(
                future: Provider.of<MostlyPlayedProvider>(context, listen: false).getMostlyPlayed(),
                builder: (context, item) {
                  return Consumer<MostlyPlayedProvider>(
                    builder: (context, mostly, child) {
                      if (mostly.mostPlayedSongsNotifier.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Mostly Songs?',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        );
                      } else {
                        final temp = mostly.mostPlayedSongsNotifier.reversed.toList();
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
                                  'No Mostly Songs!!!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }

                            return Listtiles(
                              songModel: mostlySongs,
                              isRecent: true,
                              recentLength: mostlySongs.length > 5 ? 5 : mostlySongs.length,
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
