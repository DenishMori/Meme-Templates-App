import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_img/provider/flag_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<File> urlToFile(String imageUrl) async {
  Random rng = Random();

  Directory generalDownloadDir = Directory(
    '/storage/emulated/0/Download/Meme_Saver',
  );
  if (!await generalDownloadDir.exists()) {
    await generalDownloadDir.create();
  }
  String tempPath = generalDownloadDir.path;
  File file = File('$tempPath${rng.nextInt(100)}.jpg');
  http.Response response = await http.get(Uri.parse(imageUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}

saveMeme(String url, BuildContext context) async {
  if (await requestPermission(Permission.manageExternalStorage)) {
    Dio dio = Dio();
    Random rng = Random();

    Directory generalDownloadDir = Directory(
      '/storage/emulated/0/Download/Meme_Saver',
    );
    if (!await generalDownloadDir.exists()) {
      await generalDownloadDir.create();
    }
    String tempPath = generalDownloadDir.path;
    await dio.download(
      url,
      '$tempPath${rng.nextInt(100)}.jpg',
      onReceiveProgress: (actualBytes, totalBytes) async {
        print("object ${((actualBytes / totalBytes) * 100).floor() == 100}");
        await Future.delayed(Duration.zero, () {
          if (((actualBytes / totalBytes) * 100).floor() == 100) {
            Provider.of<FlagProvider>(context, listen: false).downloaded(true);
          }
        });
      },
    );
  }
}

Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
