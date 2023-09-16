import 'dart:async';

import 'package:flutter/material.dart';
import 'package:full_screen_img/provider/flag_provider.dart';
import 'package:full_screen_img/screen/full_image_screen/components/download_share_tile.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class FullImagePreview extends StatefulWidget {
  const FullImagePreview({super.key, required this.imgPath});
  final List<String?> imgPath;

  @override
  State<FullImagePreview> createState() => _FullImagePreviewState();
}

class _FullImagePreviewState extends State<FullImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Meme Templete ${Provider.of<FlagProvider>(context).getimgIndex!}",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Consumer<FlagProvider>(builder: (context, provider, child) {
              return PhotoViewGallery.builder(
                backgroundDecoration: const BoxDecoration(color: Colors.white),
                itemCount: widget.imgPath.length,
                builder: (_, index) {
                  final imageUrl = widget.imgPath[provider.getimgIndex!];
                  return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageUrl!));
                },
                onPageChanged: (index) async {
                  await Future.delayed(Duration.zero, () {
                    Provider.of<FlagProvider>(context, listen: false)
                        .setIndex(provider.getimgIndex! + 1);
                  });
                },
                gaplessPlayback: true,
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: DownloadShareTile(
                imgURL: widget.imgPath
                    .elementAt(Provider.of<FlagProvider>(context).getimgIndex!),
              ),
            )
          ],
        ));
  }
}
