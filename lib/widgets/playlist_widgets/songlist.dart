import 'package:flutter/material.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';

class Songlist_custom extends StatelessWidget {
  const Songlist_custom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 75,
                width: 90,
                color: Colors.white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Song Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                ),
                Text(
                  'Artist name',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: AppBarButton(
                  color: Colors.white,
                  iconData: Icons.more_vert_rounded,
                  buttonAction: () {
                    custombottomsheet(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
