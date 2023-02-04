import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => SongmModelProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}


// ListView.builder(
//           itemCount: item.data!.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               leading: Container(
//                 height: 80,
//                 width: 60,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.black,
//                 ),
//               ),
//               title: Text(
//                 item.data![index].displayNameWOExt,
//                 style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               subtitle: Text(
//                 '${item.data![index].artist}',
//                 style: const TextStyle(color: Colors.white54),
//               ),
//               trailing: const Icon(
//                 Icons.more_horiz,
//                 color: Colors.white,
//               ),
//             );
//           },
//         );