import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/controller/favourites_con.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/screens/playlist/all_playlist%20_1.dart';
import 'package:music_application/screens/playlist/playlist_allsngAdd.dart';
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
  bool? shuffle = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  GetAllSongController.audioPlayer.loopMode == LoopMode.one ? GetAllSongController.audioPlayer.setLoopMode(LoopMode.all) : GetAllSongController.audioPlayer.setLoopMode(LoopMode.one);
                },
                icon: StreamBuilder<LoopMode>(
                  stream: GetAllSongController.audioPlayer.loopModeStream,
                  builder: (context, repeat) {
                    final loopMode = repeat.data;

                    if (LoopMode.one == loopMode) {
                      return const Icon(
                        Icons.repeat_one,
                        color: Colors.white,
                      );
                    } else {
                      return const Icon(
                        Icons.repeat,
                        color: Colors.white,
                      );
                    }
                  },
                )),
            AppBarButton(
                iconData: Icons.playlist_add,
                buttonAction: () {
                  modelsheet(context, widget.favsongmodel, formkey);
                  // Navigator.pop(context);
                },
                color: Colors.white),
            AppBarButton(
                iconData: FavoriteDb.isFavor(widget.favsongmodel) ? Icons.favorite : Icons.favorite_border,
                buttonAction: () {
                  if (FavoriteDb.isFavor(widget.favsongmodel)) {
                    FavoriteDb.delete(widget.favsongmodel.id);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Center(
                          child: Center(
                            child: Text(
                              'Song Removed From Favourite',
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                        duration: const Duration(seconds: 1),
                        margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.9, left: 90, right: 75),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  } else {
                    FavoriteDb.add(widget.favsongmodel);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Center(
                          child: Center(
                            child: Text(
                              'Song Added To Favourite',
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                        duration: const Duration(seconds: 1),
                        margin: EdgeInsets.only(bottom: mediaQuery.size.height * 0.9, left: 90, right: 75),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }
                  FavoriteDb.favoriteSongs.notifyListeners();
                },
                color: Colors.white),
            IconButton(
              onPressed: () {
                setState(() {
                  shuffle == false ? GetAllSongController.audioPlayer.setShuffleModeEnabled(true) : GetAllSongController.audioPlayer.setShuffleModeEnabled(false);
                });
              },
              icon: StreamBuilder<bool>(
                stream: GetAllSongController.audioPlayer.shuffleModeEnabledStream,
                builder: (context, data) {
                  shuffle = data.data ?? false;

                  if (shuffle!) {
                    return const Icon(
                      Icons.shuffle_rounded,
                      color: Colors.white,
                    );
                  } else {
                    return const Icon(
                      Icons.shuffle_rounded,
                      color: Colors.white60,
                    );
                  }
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
