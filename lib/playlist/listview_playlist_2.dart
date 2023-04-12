import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/playlist/playlist_single_3.dart';
import 'package:music_application/providers/playlist_provider.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PlaylistListview extends StatelessWidget {
  PlaylistListview({
    super.key,
    required this.musicList,
  });

  final Box<SongsDB> musicList;

  TextEditingController nameeditcontroller0 = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final data = musicList.values.toList()[index];

        // print('favad ====  ${data.songid} ${data.name}');

        return ValueListenableBuilder(
          valueListenable: Hive.box<SongsDB>('playlist').listenable(),
          builder: (BuildContext context, Box<SongsDB> musiclist, Widget? child) {
            return Padding(
              padding: EdgeInsets.all(1.h),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Playlist(
                        playlist: data,
                        index: index,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 10.h,
                        width: 10.h,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('Assets/img/favad.jpg'),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                    SizedBox(width: 5.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20.sp, color: Colors.white),
                        ),
                        SizedBox(height: 1.h),
                        // const Text(
                        //   'Instrumental',
                        //   style: TextStyle(fontSize: 15, color: Colors.white),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: const Color.fromARGB(218, 2, 12, 42),
                          context: context,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bottomsheetlist(
                                    icon: Icons.edit,
                                    title: 'Rename',
                                    buttonpress: () {
                                      Navigator.of(context).pop();

                                      editPlaylist(index, context, formkey, nameeditcontroller0, data);
                                    },
                                  ),
                                  SizedBox(height: 2.h),
                                  bottomsheetlist(
                                    title: 'Delete Playlist',
                                    icon: Icons.delete,
                                    buttonpress: () {
                                      Navigator.of(context).pop();

                                      deletePlaylist(context, musiclist, index);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      itemCount: musicList.length,
    );
  }

  Future editPlaylist(index, context, formkey, namecontroller, SongsDB music) {
    namecontroller = TextEditingController(text: music.name);
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        children: [
          SimpleDialogOption(
            child: Text(
              'Edit playlist name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 3.h,
              ),
            ),
          ),
          SizedBox(height: 1.h),
          SimpleDialogOption(
            child: Form(
              key: formkey,
              child: TextFormField(
                maxLength: 12,
                controller: namecontroller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 3.h,
                  fontWeight: FontWeight.w700,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter your playlist name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 2.h, fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  updateplaylistname(index, formkey, namecontroller, context);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 2.h,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateplaylistname(index, formkey, playlistnamectrl, context) {
    if (formkey.currentState!.validate()) {
      final names = playlistnamectrl.text.trim();
      if (names.isEmpty) {
        return;
      } else {
        final playlistnam = SongsDB(name: names, songid: []);
        Provider.of<PlayListProvider>(context, listen: false).editlist(index, playlistnam);
      }
    }
  }

  Future<dynamic> deletePlaylist(context, musicList, index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Delete Playlist',
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                musicList.deleteAt(index);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: MediaQuery.of(context).size.width * 3.5 / 5,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black,
                  content: const Text(
                    'Playlist is deleted',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(milliseconds: 450),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
