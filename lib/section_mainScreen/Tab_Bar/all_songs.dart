import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/screens/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({super.key});

  @override
  State<AllSongs> createState() => _AllSongsState();
}

// final OnAudioQuery _audioQuery = OnAudioQuery();

// final AudioPlayer audioPlayer = AudioPlayer();

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();

  List<SongModel> allsongs = [];
  @override
  void initState() {
    super.initState();
    requestper();
  }

  void requestper() {
    Permission.storage.request();
  }

  List<SongModel> songs = <SongModel>[];

  int currentIndex = 0;

  playSong(String? uri) {
    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioPlayer.play();
    } on Exception {
      log("Error song" as num);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[700],
      child: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, items) {
          if (items.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (items.data!.isEmpty) {
            return const Center(
              child: Text(
                'NO Songs found!!',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            itemCount: items.data!.length,
            itemBuilder: (context, index) {
              allsongs.addAll(items.data!);
              return ListTile(
                leading: QueryArtworkWidget(
                  id: items.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                ),
                title: Text(
                  items.data![index].displayNameWOExt,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${items.data![index].artist}',
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                onTap: () {
                  // playSong(items.data![index].uri);

                  context.read<SongmModelProvider>().setId(items.data![index].id);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NowPlaying(
                          audioPlayer: audioPlayer,
                          songModel: allsongs,
                        ),
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AllSongs extends StatefulWidget {
//   const AllSongs({super.key});

//   @override
//   State<AllSongs> createState() => _AllSongsState();
// }

// class _AllSongsState extends State<AllSongs> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     requestPermission();
//   }

//   void requestPermission() {
//     Permission.storage.request();
//   }

//   final audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<SongModel>>(
//       future: audioQuery.querySongs(
//         sortType: null,
//         orderType: OrderType.ASC_OR_SMALLER,
//         uriType: UriType.EXTERNAL,
//         ignoreCase: true,
//       ),
//       builder: (context, items) {
//         if (items.data == null) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (items.data!.isEmpty) {
//           return const Center(
//             child: Text(
//               'NO Songs found!!',
//               style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           );
//         }
//         return ListView.builder(
//           itemCount: 100,
//           itemBuilder: (context, index) {
//             return ListTile(
//               // leading: QueryArtworkWidget(
//               //   id: items.data![index].id,
//               //   type: ArtworkType.AUDIO,
//               //   nullArtworkWidget: const Icon(Icons.music_note),
//               // ),
//               title: Text(
//                 items.data![index].displayNameWOExt,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               subtitle: Text(
//                 '${items.data![index].artist}',
//                 style: const TextStyle(color: Colors.white54),
//               ),
//               trailing: const Icon(
//                 Icons.more_horiz,
//                 color: Colors.white,
//               ),
//               onTap: () {
//                 // playSong(items.data![index].uri);
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //       builder: (context) => NowPlaying(
//                 //         audioPlayer: _audioPlayer,
//                 //         songModelList: allSongs,
//                 //       ),
//                 //     ));
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }
