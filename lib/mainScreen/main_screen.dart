import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/mainScreen/first_main.dart';
import 'package:music_application/providers/lastadded_provider.dart';
import 'package:music_application/providers/search_provider.dart';
import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/screens/settings/settings.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/all_songs.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/for_you.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:music_application/screens/mini_player.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Color mainColor = const Color.fromARGB(218, 3, 16, 56);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LastAddedProvider>(context, listen: false).songsLastPlayed();
    });
    var searchProvider = Provider.of<SearchProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchProvider.songsLoading();
    });
    var mediaQuery = MediaQuery.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          leadingWidth: 5.h,
          elevation: 0,
          backgroundColor: mainColor,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.h),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Favourites(),
                  ),
                );
              },
            ),
            AppBarButton(
              color: Colors.white,
              iconData: Icons.search,
              buttonAction: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>  Search(),
                ));
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    collapsedHeight: mediaQuery.size.height * 0.4,
                    expandedHeight: 30.h,
                    flexibleSpace: const MainFirst(),
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
              body: TabBarView(
                children: [
                  AllSongs(),
                  const ForYou(),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0.h,
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
      margin: EdgeInsets.symmetric(horizontal: 5.h, vertical: 1.h),
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
