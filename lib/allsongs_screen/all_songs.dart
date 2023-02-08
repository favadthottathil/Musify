import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/allsongs_screen/listitle.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({
    super.key,
  });

  @override
  State<AllSongs> createState() => _AllSongsState();
}

class _AllSongsState extends State<AllSongs> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();

  List<SongModel> allsongs = [];

  @override
  void initState() {
    super.initState();
    requestper();
  }

  void requestper() async {
    // Permission.storage.request();
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: audioQuery.querySongs(
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

        return Listtiles(songModel: items.data!);
      },
    );
  }
}
