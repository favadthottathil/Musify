import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/player_controll.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

  // List<AudioSource> songList = [];

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

  // void listenTosongIndex() {
  //   widget.audioPlayer.currentIndexStream.listen((event) {
  //     setState(() {
  //       if (event != null) {
  //         currentindex = event;
  //       }
  //       context.read<SongmodelProvider>().setid(widget.songModel[currentindex].id);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
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
            color: const Color.fromARGB(218, 3, 16, 56),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: QueryArtworkWidget(
                  id: widget.songModel[currentindex].id,
                  type: ArtworkType.AUDIO,
                  keepOldArtwork: true,
                  artworkHeight: 250,
                  artworkWidth: 250,
                  artworkBorder: BorderRadius.circular(1),
                  artworkFit: BoxFit.cover,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 200,
                  ),
                ),
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
                      _position.toString().split(".").first,
                      style: const TextStyle(color: Colors.white38),
                    ),
                    Text(
                      _duration.toString().split(".")[0],
                      style: const TextStyle(color: Colors.white38),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
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

// class ArtWorkWidget extends StatelessWidget {
//   const ArtWorkWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return QueryArtworkWidget(
//       id: Widget.songmodel,
//       type: ArtworkType.AUDIO,
//       artworkHeight: 200,
//       artworkWidth: 300,
//       artworkBorder: BorderRadius.circular(4),
//       artworkFit: BoxFit.fill,
//       nullArtworkWidget: const Icon(
//         Icons.music_note,
//         size: 200,
//       ),
//     );
//   }
// }
