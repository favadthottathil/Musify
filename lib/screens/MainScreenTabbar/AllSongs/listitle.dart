import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_application/controller/favourites_con.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/screens/playlist/playlist_allsngAdd.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../../playing_screen/now_playing.dart';

class Listtiles extends StatefulWidget {
  const Listtiles({super.key, required this.songModel, this.recentLength, this.isRecent = false});

  final List<SongModel> songModel;
  final dynamic recentLength;
  final bool isRecent;

  @override
  State<Listtiles> createState() => _ListtileState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

TextEditingController namecontroller1 = TextEditingController();

class _ListtileState extends State<Listtiles> {
  List<SongModel> allsongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.isRecent ? widget.recentLength : widget.songModel.length,
      itemBuilder: (context, index) {
        allsongs.addAll(widget.songModel);
        return Padding(
          padding:  EdgeInsets.all(8.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: Colors.white10,
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: widget.songModel[index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget:  Padding(
                  padding: EdgeInsets.only(left: 7.w, top: 6.h),
                  child:  Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
              title: Text(
                widget.songModel[index].displayNameWOExt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              subtitle: Padding(
                padding:  EdgeInsets.only(top: 8.h),
                child: Text(
                  widget.songModel[index].artist.toString(),
                  style: const TextStyle(color: Colors.white54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                onPressed: () {
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
                              icon: Icons.playlist_add,
                              title: 'Add to Playlist',
                              buttonpress: () {
                                modelsheet(context, widget.songModel[index], formkey);
                              },
                            ),
                             SizedBox(height: 20.h),
                            ValueListenableBuilder(
                              valueListenable: FavoriteDb.favoriteSongs,
                              builder: (context, data, child) {
                                return bottomsheetlist(
                                  title: FavoriteDb.isFavor(widget.songModel[index]) ? 'remove from favourite' : 'add to favorite',
                                  icon: Icons.favorite,
                                  buttonpress: () {
                                    if (FavoriteDb.isFavor(widget.songModel[index])) {
                                      FavoriteDb.delete(widget.songModel[index].id);
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: const Center(
                                          child: Text(
                                            'Song Removed from Favourite',
                                            maxLines: 1,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                                        duration: const Duration(seconds: 1),
                                        margin:  EdgeInsets.symmetric(horizontal: 84.w, vertical: 40.h),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.r),
                                        ),
                                      ));
                                    } else {
                                      FavoriteDb.add(widget.songModel[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Center(
                                            child: Text(
                                              'Song Added To Favourite',
                                              maxLines: 1,
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
                                          duration: const Duration(seconds: 1),
                                          margin:  EdgeInsets.symmetric(horizontal: 84.w, vertical: 40.h),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5.r),
                                          ),
                                        ),
                                      );
                                    }
                                    FavoriteDb.favoriteSongs.notifyListeners();
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              onTap: () {
                GetAllSongController.audioPlayer.setAudioSource(
                  GetAllSongController.createSongList(widget.songModel),
                  initialIndex: index,
                );

                RecentController.addRecent(widget.songModel[index].id);

                Mostlycontroller.addMostlyPlayed(
                  widget.songModel[index].id,
                );

                context.read<SongModelProvider>().setId(widget.songModel[index].id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songModel: widget.songModel,
                      count: widget.songModel.length,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
