import 'package:flutter/material.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/allsongs_screen/listitle.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color.fromARGB(218, 3, 16, 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(218, 3, 16, 56),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 200,
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
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 800,
                  child: Listtiles(songModel: foundSongs),
                )
              ],
            ),
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


// Checkbox