import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/screens/playing_screen/player_controll.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    required this.songModel,
    this.count = 0,
  });

  // add songmodel variable

  final List<SongModel> songModel;
  // final AudioPlayer audioPlayer;

  final int count;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();

  bool firstsong = false;
  bool lastsong = false;

  int large = 0;



  int currentindex = 0;

  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        GetAllSongController.currentIndexes = index;
        if (mounted) {
          setState(() {
            large = widget.count - 1;
            currentindex = index;
            index == 0 ? firstsong = true : firstsong = false;
            index == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });

    super.initState();
    playsong();
  }

  void playsong() {
    GetAllSongController.audioPlayer.play();
    GetAllSongController.audioPlayer.durationStream.listen((d) {
      setState(() {
        _duration = d!;
      });
    });
    GetAllSongController.audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          toolbarHeight: mediaQuery.size.height * 0.1,
          backgroundColor: mainColor,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_sharp,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(218, 3, 16, 56),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 20),
              SizedBox(
                height: mediaQuery.size.height * 0.3,
                child: QueryArtworkWidget(
                  id: widget.songModel[currentindex].id,
                  type: ArtworkType.AUDIO,
                  keepOldArtwork: true,
                  artworkWidth: mediaQuery.size.width * 0.6,
                  artworkBorder: BorderRadius.circular(15),
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 200,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: TextScroll(
                  widget.songModel[currentindex].displayNameWOExt,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  mode: TextScrollMode.endless,
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
              SizedBox(height: mediaQuery.size.height * 0.1),
              PlayingControlls(count: widget.count, firstsong: firstsong, lastsong: lastsong, favsongmodel: widget.songModel[currentindex]),
            ]),
          ),
        ));
  }

  void changeduration(int seconds) {
    Duration duration = Duration(seconds: seconds);
    GetAllSongController.audioPlayer.seek(duration);
  }
}
