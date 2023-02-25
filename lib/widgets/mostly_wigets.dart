import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'playlist_widgets/custombottom_sheet.dart';

class MostListView extends StatefulWidget {
  const MostListView({
    super.key,
    required this.mostlysongs,
  });

  final List<SongModel> mostlysongs;

  @override
  State<MostListView> createState() => _MostListViewState();
}

class _MostListViewState extends State<MostListView> {
  // final List<SongModel> songmodel;
  List<SongModel> allsongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          allsongs.addAll(widget.mostlysongs);
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const Playlist(),
                //     ));
              },
              child: Row(
                children: [
                  QueryArtworkWidget(
                    id: widget.mostlysongs[index].id,
                    type: ArtworkType.AUDIO,
                    artworkWidth: 70,
                    artworkHeight: 70,
                    keepOldArtwork: true,
                    artworkBorder: BorderRadius.circular(6),
                    nullArtworkWidget: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black45,
                      ),
                      height: 70,
                      width: 70,
                      child: const Icon(
                        Icons.music_note,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Column(
                    children: [
                      Container(
                        color: Colors.amber,
                        child: Text(
                          widget.mostlysongs[index].displayNameWOExt,
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.mostlysongs[index].artist.toString(),
                        style: const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: const Color.fromARGB(218, 2, 12, 42),
                        context: context,
                        builder: (context) {
                          return CustomModelSheet(
                            firIcon: Icons.favorite_border,
                            firText: 'Add To Favorite Songs',
                            firpress: () {},
                            secIcon: Icons.playlist_add,
                            secText: 'Add To Playlist',
                            secpress: () {},
                            thirIcon: Icons.share,
                            thirText: 'Share',
                            thirpress: () {},
                            forIcon: Icons.info_outline,
                            forText: 'Details',
                            forpress: () {},
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
        itemCount: widget.mostlysongs.length);
  }
}
