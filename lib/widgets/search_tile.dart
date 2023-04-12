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
import '../../../playing_screen/now_playing.dart';

class SearchTile extends StatefulWidget {
  const SearchTile({super.key, required this.songModel, this.recentLength, this.isRecent = false});

  final List<SongModel> songModel;
  final dynamic recentLength;
  final bool isRecent;

  @override
  State<SearchTile> createState() => _SearchTileState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

TextEditingController namecontroller1 = TextEditingController();

class _SearchTileState extends State<SearchTile> {
  List<SongModel> allsongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.isRecent ? widget.recentLength : widget.songModel.length,
      itemBuilder: (context, index) {
        allsongs.addAll(widget.songModel);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white10,
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: widget.songModel[index].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const Padding(
                  padding: EdgeInsets.only(left: 7, top: 6),
                  child: Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 30,
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
                padding: const EdgeInsets.only(top: 8),
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
                            const SizedBox(height: 20),
                            Consumer<FavouriteProvider>(
                              builder: (context, favourite, child) {
                                return bottomsheetlist(
                                  title: favourite.isFavor(widget.songModel[index]) ? 'remove from favourite' : 'add to favorite',
                                  icon: Icons.favorite,
                                  buttonpress: () {
                                    if (favourite.isFavor(widget.songModel[index])) {
                                      favourite.delete(widget.songModel[index].id);
                                      // const remove = SnackBar(
                                      //   content: Text('Song Removed'),
                                      //   duration: Duration(seconds: 1),

                                      // );
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
                                      favourite.add(widget.songModel[index]);
                                      // const addfav = SnackBar(
                                      //   content: Text('Song Added'),
                                      //   duration: Duration(seconds: 1),
                                      // );
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

                Provider.of<RecentProvider>(context, listen: false).addRecent(widget.songModel[index].id);

                Provider.of<MostlyPlayedProvider>(context, listen: false).addMostlyPlayed(
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
      controller: ScrollController(keepScrollOffset: true),
    );
  }
}
