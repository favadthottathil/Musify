import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/playlist/listview_playlist_2.dart';
import 'package:music_application/providers/playlist_provider.dart';
import 'package:music_application/widgets/search_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AllPlaylist extends StatelessWidget {
  AllPlaylist({super.key});

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController namecontroller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
      builder: (BuildContext context, Box<SongsDB> songlist, Widget? child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(218, 3, 16, 56),
            elevation: 0,
            title: Text(
              'PlayList',
              style: TextStyle(fontSize: 25.sp, color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  newplaylist(context, formkey);
                },
                child: const Icon(Ionicons.add_circle_outline, color: Colors.white, size: 40),
              ),
              SizedBox(width: 1.h),
            ],
          ),
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Hive.box<SongsDB>('playlist').isEmpty
                ? Center(
                    child: Text(
                      'No Playlist',
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    ),
                  )
                : PlaylistListview(
                    musicList: songlist,
                  ),
          ),
        );
      },
    );
  }
}

//  NEW PLAYLIST

Future newplaylist(BuildContext context, formkey) {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            15,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New Playlist',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SimpleDialogOption(
          child: Form(
            key: formkey,
            child: TextFormField(
              controller: namecontroller1,
              maxLength: 8,
              decoration: InputDecoration(
                counterStyle: const TextStyle(
                  color: Colors.white,
                ),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Playlist name';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                namecontroller1.clear();
              },
              child: const Text(
                'cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  addButtonPressed(context);
                }
              },
              child: const Text(
                'add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

// ADD BUTTON PRESS

Future<void> addButtonPressed(context) async {
  final name = namecontroller1.text.trim();
  final playlist = SongsDB(name: name, songid: []);
  final datas = Provider.of<PlayListProvider>(context, listen: false).playlist.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(playlist.name)) {
    final snackbar3 = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: const Text(
          'playlist already exist',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 13),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar3);
    Navigator.of(context).pop();
  } else {
    Provider.of<PlayListProvider>(context, listen: false).addPlaylist(playlist);
    final snackbar4 = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        width: 300,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: const Text(
          'playlist created successfully',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar4);
    Navigator.pop(context);
    namecontroller1.clear();
  }
}
