import 'package:flutter/material.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/screens/playing_screen/now_playing.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/screens/search.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  static List<SongModel> recentsong = [];

  dynamic recentLength;

  bool isrecent = true;

  final OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RecentController.getRecent(),
      builder: (context, items) {
        return ValueListenableBuilder(
          valueListenable: RecentController.recentSongsNotifier,
          builder: (context, List<SongModel> recent, child) {
            if (recent.isEmpty) {
              return const Center(
                child: Text(
                  'No Recent Songs',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              final temp = recent.reversed.toList();
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
                      child: Text('No Recently Songs'),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: isrecent
                        ? recentsong.length > 5
                            ? 5
                            : recentsong.length
                        : recentsong.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                GetAllSongController.audioPlayer.setAudioSource(
                                  GetAllSongController.createSongList(recentsong),
                                  initialIndex: index,
                                );

                                RecentController.addRecent(recentsong[index].id);

                                context.read<SongModelProvider>().setId(recentsong[index].id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NowPlaying(
                                      songModel: recentsong,
                                      count: recentsong.length,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: QueryArtworkWidget(
                                  id: recentsong[index].id,
                                  type: ArtworkType.AUDIO,
                                  artworkFit: BoxFit.fitHeight,
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recentsong[index].displayNameWOExt.substring(0, 10),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              recentsong[index].artist!.substring(0, 9).toString(),
                              style: const TextStyle(
                                color: Colors.white30,
                                fontSize: 13,
                              ),
                            )
                          ],
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
