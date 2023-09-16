import 'dart:io';
import 'package:flutter/material.dart';
import 'package:full_screen_img/functions/functions.dart';
import 'package:full_screen_img/services/meme_serivece.dart';
import 'package:full_screen_img/widgets/meme_tile.dart';

import 'package:share_plus/share_plus.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Memes",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: MemeSeriveces.getMemes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 9.5),
                    itemCount: snapshot.data!.data!.memes!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) {
                      return MemeTile(
                        imgUrl: snapshot.data!.data!.memes![index].url!,
                        index: index,
                        imgurls: snapshot.data!.data!.memes!.map((e) {
                          return e.url!;
                        }).toList(),
                        onShare: () async {
                          File file = await urlToFile(
                              snapshot.data!.data!.memes![index].url!);
                          Share.shareXFiles([XFile(file.path)]);
                        },
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
