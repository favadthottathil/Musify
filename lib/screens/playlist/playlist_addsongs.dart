// import 'package:flutter/material.dart';
// import 'package:music_application/DB/model_db.dart';
// import 'package:music_application/controller/song_controller.dart';
// import 'package:music_application/providers/playlist_provider.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import 'package:provider/provider.dart';

// class PlaylistAdd extends StatefulWidget {
//   const PlaylistAdd({super.key, required this.playlist});

//   final SongsDB playlist;

//   @override
//   State<PlaylistAdd> createState() => _PlaylistAddState();
// }

// class _PlaylistAddState extends State<PlaylistAdd> {
//   bool isplaying = true;
//   final OnAudioQuery audioQuery = OnAudioQuery();

//   @override
//   Widget build(BuildContext context) {
//     var playlistNotifier = Provider.of<PlayListProvider>(context, listen: false).playlistNotifier;
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(218, 3, 16, 56),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(218, 3, 16, 56),
//         elevation: 0,
//         title: const Text('Add Songs'),
//       ),
//       body: FutureBuilder<List<SongModel>>(
//         future: audioQuery.querySongs(
//           sortType: null,
//           orderType: OrderType.ASC_OR_SMALLER,
//           uriType: UriType.EXTERNAL,
//           ignoreCase: true,
//         ),
//         builder: (context, item) {
//           if (item.data == null) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           if (item.data!.isEmpty) {
//             return const Center(
//               child: Text('No Song Avaialable'),
//             );
//           }
//           return ListView.builder(
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               // final data = songlist.values.toList()[index];
//               // imagechanger = Random().nextInt(6) + 1;
//               return Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: QueryArtworkWidget(
//                         id: item.data![index].id,
//                         type: ArtworkType.AUDIO,
//                         artworkWidth: 50,
//                         artworkHeight: 50,
//                         keepOldArtwork: true,
//                         // artworkBorder: BorderRadius.circular(3),
//                         nullArtworkWidget: Container(
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.black54),
//                           width: 50,
//                           height: 50,
//                           child: const Icon(
//                             Icons.music_note,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           item.data![index].displayNameWOExt,
//                           maxLines: 1,
//                           style: const TextStyle(fontSize: 15, color: Colors.white),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           item.data![index].artist.toString(),
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     Container(
//                       child: !widget.playlist.isvalue(item.data![index].id)
//                           ? IconButton(
//                               onPressed: () {
//                                 GetAllSongController.songscopy = item.data!;
//                                 setState(() {
//                                   // playlistNotifier.addListener(() {});
//                                   songAddToPlaylist(item.data![index]);
//                                   // PlaylistDb.playlistNotifier.notifyListeners();
//                                 });
//                               },
//                               icon: const Icon(
//                                 Icons.add,
//                                 color: Colors.white,
//                               ))
//                           : IconButton(
//                               onPressed: () {
//                                 setState(
//                                   () {
//                                     songdeleteFromPlaylist(item.data![index]);
//                                   },
//                                 );
//                               },
//                               icon: const Icon(
//                                 Icons.remove,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     )
//                   ],
//                 ),
//               );
//             },
//             itemCount: item.data!.length,
//           );
//         },
//       ),
//     );
//   }

//   void songAddToPlaylist(SongModel data) {
//     widget.playlist.add(data.id);
//     // print('songs added to playlsit === ${data.id}');
//     final addedToPlaylist = SnackBar(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25),
//       ),
//       width: 250,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.black,
//       content: const Text(
//         'Song added to Playlist',
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.white),
//       ),
//       duration: const Duration(seconds: 2),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(addedToPlaylist);
//   }

//   void songdeleteFromPlaylist(SongModel data) {
//     widget.playlist.deletedata(data.id);
//     final removeplaylist = SnackBar(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25),
//       ),
//       width: 250,
//       behavior: SnackBarBehavior.floating,
//       backgroundColor: Colors.black,
//       content: const Text(
//         'Song Removed from Playlist',
//         maxLines: 1,
//         textAlign: TextAlign.center,
//         style: TextStyle(color: Colors.white),
//       ),
//       duration: const Duration(seconds: 2),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(removeplaylist);
//   }
// }
