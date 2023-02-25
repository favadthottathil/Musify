import 'package:flutter/material.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';

void custombottomsheetPlaylist(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: const Color.fromARGB(218, 2, 12, 42),
    context: context,
    builder: (context) {
      return Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 25, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bottomsheetlist(icon: Icons.favorite_border, title: 'Add To ', buttonpress: () {}),
              const SizedBox(height: 20),
              bottomsheetlist(
                title: 'Add to Playlist',
                icon: Icons.playlist_add,
                buttonpress: () {},
              ),
              const SizedBox(height: 20),
              bottomsheetlist(
                title: 'Share',
                icon: Icons.share,
                buttonpress: () {},
              ),
              const SizedBox(height: 20),
              bottomsheetlist(title: 'Details', icon: Icons.info_outline, buttonpress: () {})
            ],
          ),
        ),
      );
    },
  );
}
