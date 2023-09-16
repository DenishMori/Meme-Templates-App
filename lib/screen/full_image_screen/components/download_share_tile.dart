import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_screen_img/functions/functions.dart';
import 'package:full_screen_img/provider/flag_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadShareTile extends StatelessWidget {
  const DownloadShareTile({super.key, required this.imgURL});
  final String? imgURL;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Consumer<FlagProvider>(builder: (context, provider, child) {
          return InkWell(
              onTap: () {
                saveMeme(imgURL!, context);
                Future.delayed(Duration.zero, () {
                  if (provider.getIsDownloaded!) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                            "Downloaded at /storage/emulated/0/Download/Meme_Saver")));
                    provider.downloaded(false);
                  }
                });
              },
              child: commonContainer(context, "Download"));
        }),
        InkWell(
            onTap: () async {
              File file = await urlToFile(imgURL!);
              Share.shareXFiles([XFile(file.path)]);
            },
            child: commonContainer(context, "Share"))
      ],
    );
  }

  Widget commonContainer(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.sizeOf(context).height * 0.030),
      decoration: BoxDecoration(
          color: Colors.lime, borderRadius: BorderRadius.circular(10)),
      height: MediaQuery.sizeOf(context).height * 0.055,
      width: MediaQuery.sizeOf(context).width * 0.40,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
    );
  }
}
