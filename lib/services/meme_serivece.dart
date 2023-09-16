import 'dart:convert';

import 'package:full_screen_img/model/meme_model.dart';
import 'package:http/http.dart' as http;

class MemeSeriveces {
  static Future<MemeModel?> getMemes() async {
    String url = "https://api.imgflip.com/get_memes";
    final response = await http.get(Uri.parse(url));
    MemeModel? data;
    if (response.statusCode == 200) {
      data = MemeModel.fromJson(jsonDecode(response.body));
    }
    return data;
  }
}
