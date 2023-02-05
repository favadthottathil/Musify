import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple[700],
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Favorites',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.shuffle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Shuffle',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: const [
                              Icon(
                                Icons.repeat,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Repeat',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                Center(
                    child: Text(
                  'No Songs Found',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
