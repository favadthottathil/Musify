import 'package:flutter/material.dart';
import 'package:music_application/providers/fovourite_provider.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/listitle.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

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
              child: Consumer<FavouriteProvider>(
                builder: (ctx, FavouriteProvider favorite, child) {
                  if (favorite.favoriteSongs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Favorite Songs',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30, color: Colors.white),
                      ),
                    );
                  } else {
                    final temp = favorite.favoriteSongs.reversed.toList();
                    List<SongModel> favorites = temp.toSet().toList();
                    return Listtiles(songModel: favorites);
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
