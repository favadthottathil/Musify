import 'package:flutter/material.dart';
import 'package:music_application/controller/favourites_con.dart';
import 'package:music_application/allsongs_screen/listitle.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Favorits',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 600,
              child: ValueListenableBuilder(
                valueListenable: FavoriteDb.favoriteSongs,
                builder: (ctx, List<SongModel> favorite, Widget? child) {
                  if (favorite.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Favorite Songs',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white),
                      ),
                    );
                  } else {
                    final temp = favorite.reversed.toList();
                    favorite = temp.toSet().toList();
                    return Listtiles(songModel: favorite);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
