import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Map<String, String> requestHeaders = {
  "x-api-key": "48117d48-711d-49f0-9a5d-05dd10af831f"
};

Future<List<CatImage>> fetchData() async {
  final response = await http.get(
      'https://api.thecatapi.com/v1/images/search?limit=10',
      headers: requestHeaders
  );

  if (response.statusCode == 200) {
    final parsed = List<Map<String, dynamic>>.from(json.decode(response.body));
    return parsed.map<CatImage>((json) => CatImage.fromJson(json)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;

  CatImage({this.id, this.url, this.width, this.height});

  factory CatImage.fromJson(Map<String, dynamic> json) {
    return CatImage(
      id: json['id'],
      url: json['url'],
      width: json['width'],
      height: json['height'],
    );
  }
}
