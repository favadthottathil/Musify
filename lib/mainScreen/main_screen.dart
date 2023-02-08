import 'package:flutter/material.dart';
import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/screens/settings.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/for_you.dart';

import 'package:music_application/section_foryou/playlist_main.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';

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
          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
          leading: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Settings(),
            )),
            child: Container(
              height: 5,
              width: 5,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
          actions: [
            AppBarButton(
              iconData: Icons.favorite_border,
              buttonAction: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Favourites(),
              )),
            ),
            // AppBarButton(
            //   iconData: Icons.settings,
            //   buttonAction: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => const Settings(),
            //     ));
            //   },
            // ),
            AppBarButton(
                iconData: Icons.search,
                buttonAction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Search(),
                  ));
                }),
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
                      // Stack(
                      //   children: [
                      //     Container(
                      //       height: 100,
                      //       width: 200,
                      //       color: Colors.amber,
                      //     )
                      //   ],
                      // ),
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
                                  Tab(text: 'For you'),
                                  Tab(text: 'All Songs')
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
                        height: 682,
                        child: TabBarView(
                          children: [
                            ForYou(),
                            AllSongs(),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 90,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: Wrap(
                            children: [
                              AppBarButton(iconData: Icons.skip_previous, buttonAction: () {}),
                              AppBarButton(iconData: Icons.play_circle_filled_outlined, buttonAction: () {}),
                              AppBarButton(iconData: Icons.skip_next, buttonAction: () {})
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
