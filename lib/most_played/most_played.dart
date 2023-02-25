import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/widgets/mostly_wigets.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayedList extends StatefulWidget {
  const MostPlayedList({super.key});

  @override
  State<MostPlayedList> createState() => _MostPlayedState();
}

class _MostPlayedState extends State<MostPlayedList> {
  final OnAudioQuery audioQuery = OnAudioQuery();

  static List<SongModel> mostsongs = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  Future init() async {
    await MostlyPlayedfunctions.getMostd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        elevation: 0,
        title: const Text(
          'Most Played',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder(
        future: MostlyPlayedfunctions.getMostd(),
        builder: (context, mostly) {
          return ValueListenableBuilder(
            valueListenable: MostlyPlayedfunctions.mostplayedNotifier,
            builder: (context, mostlySongs, child) {
              if (mostlySongs.isEmpty) {
                return const Center(
                  child: Text(
                    'NO Mostly Played Songs',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                );
              } else {
                final songs = mostlySongs.reversed.toList();
                mostsongs = songs.toSet().toList();

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
                          'NO Mostly Songs!!',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return MostListView(
                      mostlysongs: mostsongs,
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
