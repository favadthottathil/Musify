import 'package:flutter/material.dart';
import 'package:music_application/main.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/all_songs.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/listitle.dart';
import 'package:music_application/widgets/search_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

List<SongModel> allsongs = [];
List<SongModel> foundSongs = [];
final AudioQuery = OnAudioQuery();

class _SearchState extends State<Search> {
  @override
  void initState() {
    songsLoading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: mainColor,
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 25),
                  const Text(
                    'Search',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: mediaQuery.size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: mainColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: SizedBox(
                        height: 40,
                        width: mediaQuery.size.width * 0.5,
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) => updateList(value),
                          decoration: InputDecoration(
                            filled: true,
                            hintText: 'Search the music',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 110),
                      child: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.5),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              foundSongs.isEmpty
                  ? const Center(
                      child: Text(
                        'No Songs found',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : SearchTile(songModel: foundSongs)
            ],
          ),
        ),
      ),
    );
  }

  void songsLoading() async {
    allsongs = await AudioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    setState(() {
      foundSongs = allsongs;
    });
  }

  void updateList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where(
            (element) => element.displayNameWOExt.trim().contains(enteredText.trim()),
          )
          .toList();
    }
    setState(() {
      foundSongs = results;
    });
  }
}
