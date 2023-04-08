import 'package:flutter/material.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/providers/search_provider.dart';
import 'package:music_application/widgets/search_tile.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  // @override
  // void initState() {
  //   songsLoading();

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchProvider.songsLoading();
    });
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
                    Consumer<SearchProvider>(builder: (context, provider, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          height: 40,
                          width: mediaQuery.size.width * 0.5,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) => provider.updateList(value),
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
                      );
                    }),
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
              Consumer<SearchProvider>(builder: (context, value, child) {
                if (value.foundSongs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(height: 300),
                      Center(
                        child: Text(
                          'NO SONGS FOUND',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SearchTile(songModel: value.foundSongs);
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  // void songsLoading() async {
  //   allsongs = await audioQuery.querySongs(
  //     sortType: null,
  //     orderType: OrderType.ASC_OR_SMALLER,
  //     uriType: UriType.EXTERNAL,
  //     ignoreCase: true,
  //   );
  //   setState(() {
  //     foundSongs = allsongs;
  //   });
  // }

  // void updateList(String enteredText) {
  //   List<SongModel> results = [];
  //   if (enteredText.isEmpty) {
  //     results = allsongs;
  //   } else {
  //     results = allsongs
  //         .where(
  //           (element) => element.displayNameWOExt.trim().contains(enteredText.trim()),
  //         )
  //         .toList();
  //   }
  //   setState(() {
  //     foundSongs = results;
  //   });
  // }
}
