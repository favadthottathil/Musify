import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/mainScreen/first_main.dart';
import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/screens/settings.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/section_mainScreen/Tab_Bar/for_you.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:music_application/widgets/mini_player/mini_player.dart';

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
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
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
            NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  const SliverAppBar(
                    backgroundColor: Colors.transparent,
                    collapsedHeight: 305,
                    expandedHeight: 305,
                    flexibleSpace: MainFirst(),
                  ),
                  SliverPersistentHeader(
                    delegate: MyDelegate(
                      const TabBar(
                        tabs: [
                          Tab(text: 'All Songs'),
                          Tab(text: 'For You')
                        ],
                        indicator: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    floating: true,
                  )
                ];
              },
              body: const TabBarView(
                children: [
                  AllSongs(),
                  ForYou(),
                ],
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

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: const Color.fromARGB(218, 3, 16, 56),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
