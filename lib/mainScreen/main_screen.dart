import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';

import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/screens/settings.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/for_you.dart';

import 'package:music_application/section_foryou/playlist_main.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:music_application/widgets/mini_player/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../playlist/all_playlist _1.dart';
import '../widgets/mainscreen_widgets/name_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          elevation: 0,
          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Settings(),
              )),
              child: const Icon(Ionicons.settings_outline),
            ),
          ),
          actions: [
            AppBarButton(
                color: Colors.white,
                iconData: Icons.favorite_border,
                buttonAction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Favourites(),
                  ));
                }),
            // AppBarButton(
            //   iconData: Icons.settings,
            //   buttonAction: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const Settings(),
            //     ));
            //   },
            // ),
            AppBarButton(
              color: Colors.white,
              iconData: Icons.search,
              buttonAction: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Search(),
                ));
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              color: const Color.fromARGB(218, 3, 16, 56),
              child: SingleChildScrollView(
                child: Column(
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
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NameHome(name: 'Playlist'),
                            OutLineButton(
                              onpressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AllPlaylist(),
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(
                      height: 200,
                      child: PlayListMain(),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TabBar(
                              // isScrollable: true,
                              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              tabs: [
                                Tab(text: 'All Songs'),
                                Tab(text: 'For You')
                              ],
                              indicator: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: double.infinity,
                      height: 800,
                      child: TabBarView(
                        children: [
                          AllSongs(),
                          ForYou(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  if (GetAllSongController.audioPlayer.currentIndex != null)
                    Column(
                      children: const [
                        MiniPlayer()
                      ],
                    )
                  else
                    const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}







//  Wrap(
//                       children: [
//                         IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous), color: Colors.white, iconSize: 35),
//                         const SizedBox(width: 10),
//                         IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle), color: Colors.white, iconSize: 35),
//                         const SizedBox(width: 10),
//                         IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next), color: Colors.white, iconSize: 35),
//                       ],
//                     ),