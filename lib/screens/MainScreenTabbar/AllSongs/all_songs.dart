import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_application/providers/allsongs_provider.dart';
import 'package:music_application/providers/fovourite_provider.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/listitle.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

List<SongModel> startsongs = [];

class AllSongs extends StatelessWidget {
  AllSongs({
    super.key,
  });

  List<SongModel> allsongs = [];

  final OnAudioQuery audioQuery = OnAudioQuery();

  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllSongsProvider>(context, listen: false).requestper();
    });
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
          return const Center(child: Text("No Songs Found!!"));
        }
        startsongs = items.data!;
        // if (!FavoriteDb.isInitialized) {
        //   FavoriteDb.initialize(items.data!);
        // }

        if (Provider.of<FavouriteProvider>(context, listen: false).isInitialized) {
          Provider.of<FavouriteProvider>(context, listen: false).initialize(items.data!);
        }

        GetAllSongController.songscopy = items.data!;

        return Listtiles(songModel: items.data!);
      },
    );
  }
}
