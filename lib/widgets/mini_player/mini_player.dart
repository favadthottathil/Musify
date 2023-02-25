import 'package:flutter/material.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool firstSong = false;

bool isPlaying = false;

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NowPlaying(songModel: GetAllSongController.playingsong),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 90,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black87,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: StreamBuilder(
                  stream: GetAllSongController.audioPlayer.playingStream,
                  builder: (context, snapshot) {
                    bool? playingstage = snapshot.data;

                    return QueryArtworkWidget(
                      id: GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id,
                      type: ArtworkType.AUDIO,
                      keepOldArtwork: true,
                      artworkHeight: 60,
                      artworkWidth: 60,
                      artworkBorder: BorderRadius.circular(70),
                      artworkFit: BoxFit.fill,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<bool>(
                      stream: GetAllSongController.audioPlayer.playingStream,
                      builder: (context, snapshot) {
                        bool? playingstate = snapshot.data;

                        return Text(
                          GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].displayNameWOExt,
                          style: const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Wrap(
                      children: [
                        firstSong
                            ? const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.skip_previous),
                                color: Colors.white,
                                iconSize: 35,
                              )
                            : IconButton(
                                onPressed: () async {
                                  RecentController.addRecent(GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id);

                                  if (GetAllSongController.audioPlayer.hasPrevious) {
                                    await GetAllSongController.audioPlayer.seekToPrevious();
                                    await GetAllSongController.audioPlayer.play();
                                  } else {
                                    await GetAllSongController.audioPlayer.play();
                                  }
                                },
                                icon: const Icon(Icons.skip_previous),
                                color: Colors.white,
                                iconSize: 35,
                              ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              isPlaying = !isPlaying;
                            });

                            if (GetAllSongController.audioPlayer.playing) {
                              await GetAllSongController.audioPlayer.pause();
                              setState(() {});
                            } else {
                              await GetAllSongController.audioPlayer.play();
                              setState(() {});
                            }
                          },
                          icon: StreamBuilder<bool>(
                            stream: GetAllSongController.audioPlayer.playingStream,
                            builder: (context, snapshot) {
                              bool? playingstage = snapshot.data;
                              if (playingstage != null && playingstage) {
                                return const Icon(Icons.pause_circle);
                              } else {
                                return const Icon(Icons.play_circle);
                              }
                            },
                          ),
                          color: Colors.white,
                          iconSize: 35,
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () async {
                            RecentController.addRecent(GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id);

                            if (GetAllSongController.audioPlayer.hasNext) {
                              await GetAllSongController.audioPlayer.seekToNext();
                              await GetAllSongController.audioPlayer.play();
                            } else {
                              await GetAllSongController.audioPlayer.play();
                            }
                          },
                          icon: const Icon(Icons.skip_next),
                          color: Colors.white,
                          iconSize: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}