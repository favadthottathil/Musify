import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/mainScreen/first_main.dart';
import 'package:music_application/screens/favorites.dart';
import 'package:music_application/screens/search.dart';
import 'package:music_application/screens/settings/settings.dart';
import 'package:music_application/screens/MainScreenTabbar/AllSongs/all_songs.dart';
import 'package:music_application/screens/MainScreenTabbar/ForYou/for_you.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:music_application/screens/mini_player.dart';

Color mainColor = const Color.fromARGB(218, 3, 16, 56);

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
        backgroundColor: mainColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          leading: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Settings(),
            )),
            child: const Icon(Ionicons.settings_outline),
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
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    collapsedHeight: 320.h,
                    expandedHeight: 310.h,
                    flexibleSpace: const MainFirst(),
                  ),
                  SliverPersistentHeader(
                    delegate: MyDelegate(
                      TabBar(
                        tabs: const [
                          Tab(text: 'All Songs'),
                          Tab(text: 'For You')
                        ],
                        indicator: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.r),
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
              bottom: 0.h,
              left: 12.w,
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
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
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
