import 'package:flutter/material.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';
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

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: isMostplayed
                        ? mostlySongs.length > 4
                            ? 4
                            : mostlySongs.length
                        : mostlySongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 100,
                        width: 130,
                        decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Column(
                            children: [
                              QueryArtworkWidget(
                                id: mostlySongs[index].id,
                                type: ArtworkType.AUDIO,
                                artworkHeight: 90,
                                artworkWidth: 90,
                                nullArtworkWidget: const Padding(
                                  padding: EdgeInsets.only(left: 7, top: 6),
                                  child: Icon(
                                    Icons.music_note,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: 90,
                              //   height: 90,
                              // ),
                              const SizedBox(height: 18),
                              Container(
                                height: 15,
                                width: 100,
                                child: Text(
                                  mostlySongs[index].displayNameWOExt,
                                  maxLines: 1,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.headphones_outlined,
                                    color: Colors.white54,
                                    size: 20,
                                  ),
                                  SizedBox(width: 3),
                                  // Text(
                                  //   '5',
                                  //   style: TextStyle(color: Colors.white54),
                                  // )
                                ],
                              )
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
