import 'dart:async';

import 'package:flutter/material.dart';
import 'package:full_screen_img/functions/functions.dart';

import 'package:full_screen_img/provider/flag_provider.dart';
import 'package:full_screen_img/screen/full_image_screen/full_image_preview.dart';
import 'package:provider/provider.dart';

class MemeTile extends StatelessWidget {
  const MemeTile(
      {super.key,
      required this.imgUrl,
      required this.onShare,
      required this.imgurls,
      required this.index});
  final String imgUrl;
  final List<String?> imgurls;
  final void Function()? onShare;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return FullImagePreview(imgPath: imgurls);
        }));
        await Future.delayed(Duration.zero, () {
          Provider.of<FlagProvider>(context, listen: false).setIndex(index);
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(2, 5),
              ),
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
                width: MediaQuery.sizeOf(context).width,
              ),
            ),
            Positioned(
              bottom: 1,
              right: 0,
              left: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Consumer<FlagProvider>(builder: (context, provider, child) {
                      return InkWell(
                        onTap: () {
                          saveMeme(
                            imgUrl,
                            context,
                          );
                          Future.delayed(Duration.zero, () {
                            if (provider.getIsDownloaded!) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                          "Downloaded at /storage/emulated/0/Download/Meme_Saver")));
                              provider.downloaded(false);
                            }
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.download,
                              color: Colors.lime,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Save",
                            ),
                          ],
                        ),
                      );
                    }),
                    Container(
                      width: 2,
                      height: MediaQuery.sizeOf(context).height * 0.025,
                      color: Colors.lime,
                    ),
                    InkWell(
                      onTap: onShare,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.lime,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Share"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
