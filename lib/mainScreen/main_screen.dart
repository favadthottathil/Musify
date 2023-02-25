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
        body: SafeArea(
          child: Stack(
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
                top: 570,
                left: 15,
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
      ),
    );
  }
}

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

bool firstSong = false;

bool isPlaying = false;

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  void initState() {
    GetAllSongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null) {
        setState(() {
          index == 0 ? firstSong = true : firstSong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NowPlaying(songModel: GetAllSongController.playingsong),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 90,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black87,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: StreamBuilder(
                  stream: GetAllSongController.audioPlayer.playingStream,
                  builder: (context, snapshot) {
                    bool? playingstage = snapshot.data;

                    return SizedBox(
                      height: 60,
                      width: 60,
                      child: QueryArtworkWidget(
                        id: GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].id,
                        type: ArtworkType.AUDIO,
                        keepOldArtwork: true,
                        artworkHeight: 60,
                        artworkWidth: 60,
                        artworkBorder: BorderRadius.circular(70),
                        artworkFit: BoxFit.fill,
                        nullArtworkWidget: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<bool>(
                      stream: GetAllSongController.audioPlayer.playingStream,
                      builder: (context, snapshot) {
                        // bool? playingstate = snapshot.data;

                        return SizedBox(
                          height: 20,
                          width: 250,
                          child: Text(
                            GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!].displayNameWOExt,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 1,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 45,
                      width: 180,
                      child: Wrap(
                        children: [
                          firstSong
                              ? const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.skip_previous),
                                  color: Colors.white,
                                  iconSize: 35,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    RecentController.addRecent(GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!]);

                                    if (GetAllSongController.audioPlayer.hasPrevious) {
                                      await GetAllSongController.audioPlayer.seekToPrevious();
                                      await GetAllSongController.audioPlayer.play();
                                    } else {
                                      await GetAllSongController.audioPlayer.play();
                                    }
                                  },
                                  icon: const Icon(Icons.skip_previous),
                                  color: Colors.white,
                                  iconSize: 35,
                                ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                isPlaying = !isPlaying;
                              });

                              if (GetAllSongController.audioPlayer.playing) {
                                await GetAllSongController.audioPlayer.pause();
                                setState(() {});
                              } else {
                                await GetAllSongController.audioPlayer.play();
                                setState(() {});
                              }
                            },
                            icon: StreamBuilder<bool>(
                              stream: GetAllSongController.audioPlayer.playingStream,
                              builder: (context, snapshot) {
                                bool? playingstage = snapshot.data;
                                if (playingstage != null && playingstage) {
                                  return const Icon(Icons.pause_circle);
                                } else {
                                  return const Icon(Icons.play_circle);
                                }
                              },
                            ),
                            color: Colors.white,
                            iconSize: 35,
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () async {
                              RecentController.addRecent(GetAllSongController.playingsong[GetAllSongController.audioPlayer.currentIndex!]);

                              if (GetAllSongController.audioPlayer.hasNext) {
                                await GetAllSongController.audioPlayer.seekToNext();
                                await GetAllSongController.audioPlayer.play();
                              } else {
                                await GetAllSongController.audioPlayer.play();
                              }
                            },
                            icon: const Icon(Icons.skip_next),
                            color: Colors.white,
                            iconSize: 35,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
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