import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AllSongsProvider extends ChangeNotifier {
  OnAudioQuery audioQuery = OnAudioQuery();

  void requestper() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }

    Permission.storage.request();
  }
}
