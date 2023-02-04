import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/all_songs.dart';
import 'package:music_application/section_nowplaying/image.dart';
import 'package:music_application/songmodel_provider/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({super.key, required this.songModel, required this.audioPlayer});

  // add songmodel variable

  final List<SongModel> songModel;
  final AudioPlayer audioPlayer;

  // void playNextSong() {
  //   if (currentSongIndex + 1 >= songlist.length) {
  //     currentSongIndex = 0;
  //   } else {
  //     currentSongIndex++;
  //   }
  // }

  // void playPreviousSong() {
  //   if (currentSongIndex - 1 < 0) {
  //     currentSongIndex = songlist.length - 1;
  //   } else {
  //     currentSongIndex--;
  //   }
  // }

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool _isplaying = false;

  List<AudioSource> songList = [];

  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    playsong();
  }

  void playsong() {
    try {
      // widget.audioPlayer.setAudioSource(
      //   AudioSource.uri(
      //     Uri.parse(
      //       widget.songModel.uri!,
      //     ),
      //     tag: MediaItem(
      //       id: "${widget.songModel.id}",
      //       title: widget.songModel.displayNameWOExt,
      //       album: '${widget.songModel.album}',
      //       artUri: Uri.parse('https://example.com/albumart.jpg'),
      //     )));

      for (var element in widget.songModel) {
        songList.add(AudioSource.uri(
            Uri.parse(
              element.uri!,
            ),
            tag: MediaItem(
              id: "${element.id}",
              title: element.displayNameWOExt,
              album: '${element.album}',
              artUri: Uri.parse(element.id.toString()),
            )));
      }

      widget.audioPlayer.setAudioSource(ConcatenatingAudioSource(
        children: songList,
      ));

      widget.audioPlayer.play();
      _isplaying = true;
    } on Exception {
      log('Cannot parse Song' as num);
    }

    widget.audioPlayer.durationStream.listen((d) {
      if (d != null) {
        setState(() {
          _duration = d;
        });
      }
    });
    widget.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });

    listenTosongIndex();
  }

  void listenTosongIndex() {
    widget.audioPlayer.currentIndexStream.listen((event) {
      setState(() {
        if (event != null) {
          currentindex = event;
        }
        context.read<SongModelProvider>().setid(widget.songModel[currentindex].id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.deepPurple[800],
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.deepPurple[800],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const SizedBox(
                height: 250,
                child: ArtWorkWidget(),
              ),
              const SizedBox(height: 35),
              Text(
                widget.songModel[currentindex].displayNameWOExt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                widget.songModel[currentindex].artist.toString() == "<unknown>" ? "Unkown Artist" : widget.songModel[currentindex].artist.toString(),
                style: const TextStyle(
                  color: Colors.white54,
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Slider(
                  value: _position.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      changeduration(value.toInt());
                      value = value;
                    });
                  },
                  min: const Duration(microseconds: 0).inSeconds.toDouble(),
                  max: _duration.inSeconds.toDouble(),
                  activeColor: Colors.white,
                  inactiveColor: Colors.white54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _position.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white38),
                    ),
                    Text(
                      _duration.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white38),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.repeat,
                        color: Colors.white54,
                        size: 30,
                      ),

                      IconButton(
                        onPressed: () {
                          if (widget.audioPlayer.hasPrevious) {
                            widget.audioPlayer.seekToPrevious();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_isplaying) {
                                      widget.audioPlayer.pause();
                                    } else {
                                      widget.audioPlayer.play();
                                    }

                                    _isplaying = !_isplaying;
                                  });
                                },
                                icon: Icon(
                                  _isplaying ? Icons.pause : Icons.play_arrow,
                                ))),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          if (widget.audioPlayer.hasNext) {
                            widget.audioPlayer.seekToNext();
                          }
                        },
                      ),
                      // const Icon(Icons.favorite_border, color: Colors.white)
                      const Icon(
                        Icons.shuffle,
                        color: Colors.white54,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeduration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}

class ArtWorkWidget extends StatelessWidget {
  const ArtWorkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: context.watch<SongmModelProvider>().id,
      type: ArtworkType.AUDIO,
      artworkHeight: 200,
      artworkWidth: 300,
      artworkBorder: BorderRadius.circular(4),
      artworkFit: BoxFit.fill,
      nullArtworkWidget: const Icon(
        Icons.music_note,
        size: 200,
      ),
    );
  }
}
