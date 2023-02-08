import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayingControlls extends StatefulWidget {
  const PlayingControlls({super.key, required this.count, required this.firstsong, required this.lastsong, required this.favsongmodel});

  final int count;
  final bool firstsong;
  final bool lastsong;
  final SongModel favsongmodel;

  @override
  State<PlayingControlls> createState() => _PlayingControllsState();
}

class _PlayingControllsState extends State<PlayingControlls> {
  bool _isplaying = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBarButton(iconData: Icons.repeat, buttonAction: () {}),
            AppBarButton(iconData: Icons.playlist_add, buttonAction: () {}),
            AppBarButton(iconData: Icons.favorite_border, buttonAction: () {}),
            AppBarButton(iconData: Icons.shuffle, buttonAction: () {})
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // const Icon(
            //   Icons.repeat,
            //   color: Colors.white54,
            //   size: 30,
            // ),

            widget.firstsong
                ? const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 40,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      if (GetAllSongController.audioPlayer.hasPrevious) {
                        GetAllSongController.audioPlayer.seekToPrevious();
                      }
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(right: 30, bottom: 25),
                child: IconButton(
                    onPressed: () {
                      if (mounted) {
                        setState(() {
                          if (GetAllSongController.audioPlayer.playing) {
                            GetAllSongController.audioPlayer.pause();
                          } else {
                            GetAllSongController.audioPlayer.play();
                          }
                          _isplaying = !_isplaying;
                        });
                      }
                    },
                    icon: Icon(
                      _isplaying ? Icons.pause : Icons.play_arrow,
                      size: 60,
                      color: const Color.fromARGB(218, 3, 16, 56),
                    )),
              )),
            ),

            widget.lastsong
                ? const IconButton(
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: null,
                  )
                : IconButton(
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      if (GetAllSongController.audioPlayer.hasNext) {
                        GetAllSongController.audioPlayer.seekToNext();
                      }
                    },
                  ),
            // const Icon(Icons.favorite_border, color: Colors.white)
            // const Icon(
            //   Icons.shuffle,
            //   color: Colors.white54,
            //   size: 30,
            // ),
          ],
        ),
      ],
    );
  }
}
