import 'package:flutter/material.dart';
import 'package:music_application/controller/favourites_con.dart';
import 'package:music_application/allsongs_screen/listitle.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedAll extends StatefulWidget {
  const MostlyPlayedAll({super.key});

  @override
  State<MostlyPlayedAll> createState() => _MostlyPlayedAllState();
}

class _MostlyPlayedAllState extends State<MostlyPlayedAll> {
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
                  const SizedBox(width: 10),
                  const Text(
                    'Recently played',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 40),
              FutureBuilder(
                future: Mostlycontroller.getMostlyPlayed(),
                builder: (context, item) {
                  return ValueListenableBuilder(
                    valueListenable: Mostlycontroller.mostPlayedSongsNotifier,
                    builder: (BuildContext context, List<SongModel> mostly, child) {
                      if (mostly.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Recent Songs?',
                            style: TextStyle(fontSize: 30, color: Colors.white),
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
                                  'No Recently Songs!!!',
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
