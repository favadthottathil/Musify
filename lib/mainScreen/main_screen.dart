import 'package:flutter/material.dart';
import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/all_songs.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/for_you.dart';

import 'package:music_application/section_foryou/playlist_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple[700],
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Favourites(),
                ));
              },
              icon: const Icon(Icons.favorite_border),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Search(),
                ));
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            color: Colors.deepPurple[700],
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Musicly',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const SizedBox(
                      height: 200,
                      child: PlayListMain(),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 250,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TabBar(
                              tabs: [
                                Tab(text: 'For you'),
                                Tab(text: 'All Songs')
                              ],
                              indicator: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 680,
                  child: const TabBarView(children: [
                    ForYou(),
                    AllSongs()
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
