import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playlist/playlist_allsngAdd.dart';
import 'package:music_application/providers/fovourite_provider.dart';
import 'package:music_application/providers/mostlyplayed_provider.dart';
import 'package:music_application/providers/recentsongs_provider.dart';
import 'package:music_application/songmodel_provider/songmodel_provider.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../playing_screen/now_playing.dart';

class Listtiles extends StatelessWidget {
  Listtiles({super.key, required this.songModel, this.recentLength, this.isRecent = false});

  final List<SongModel> songModel;
  final dynamic recentLength;
  final bool isRecent;

  List<SongModel> allsongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: isRecent ? recentLength : songModel.length,
      itemBuilder: (context, index) {
        allsongs.addAll(songModel);
        return Padding(
          padding: EdgeInsets.all(1.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white10,
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: songModel[index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Padding(
                  padding: EdgeInsets.only(left: 1.h, top: 1.h),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              title: Text(
                songModel[index].displayNameWOExt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  songModel[index].artist.toString(),
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
                                modelsheet(context, songModel[index], formkey);
                              },
                            ),
                            SizedBox(height: 2.h),
                            Consumer<FavouriteProvider>(
                              builder: (context, favourite, child) {
                                return bottomsheetlist(
                                  title: favourite.isFavor(songModel[index]) ? 'remove from favourite' : 'add to favorite',
                                  icon: Icons.favorite,
                                  buttonpress: () {
                                    if (favourite.isFavor(songModel[index])) {
                                      favourite.delete(songModel[index].id);
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
                                        margin: const EdgeInsets.symmetric(horizontal: 84, vertical: 40),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ));
                                    } else {
                                      favourite.add(songModel[index]);
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
                                          margin: const EdgeInsets.symmetric(horizontal: 84, vertical: 40),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                      );
                                    }
                                    // favourite.favoriteSongs.notifyListeners();
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
                  GetAllSongController.createSongList(songModel),
                  initialIndex: index,
                );

                Provider.of<RecentProvider>(context, listen: false).addRecent(songModel[index].id);

                Provider.of<MostlyPlayedProvider>(context, listen: false).addMostlyPlayed(
                  songModel[index].id,
                );

                context.read<SongModelProvider>().setId(songModel[index].id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songModel: songModel,
                      count: songModel.length,
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

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

TextEditingController namecontroller1 = TextEditingController();
