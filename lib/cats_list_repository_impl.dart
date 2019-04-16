import 'dart:async';
import 'dart:convert';

import 'package:flutter_demo_app/cat_image.dart';
import 'package:flutter_demo_app/cats_repository.dart';
import 'package:http/http.dart' as http;

const Map<String, String> REQUEST_HEADERS = {
  "x-api-key": "48117d48-711d-49f0-9a5d-05dd10af831f"
};
const String BASE_URL = "https://api.thecatapi.com/v1";

class CatsRepositoryImpl implements CatsRepository {

  @override
  Future<List<CatImage>> fetchData(int page) async {
    final response = await http.get(
        '$BASE_URL/images/search?limit=10&page=$page',
        headers: REQUEST_HEADERS);

    if (response.statusCode == 200) {
      final parsed =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      return parsed.map<CatImage>((json) => CatImage.fromJson(json)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
