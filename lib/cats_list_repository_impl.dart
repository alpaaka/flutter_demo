import 'dart:async';
import 'dart:convert';

import 'package:flutter_demo_app/cat_image.dart';
import 'package:flutter_demo_app/cats_repository.dart';
import 'package:flutter_demo_app/constants.dart';
import 'package:http/http.dart' as http;

const Map<String, String> REQUEST_HEADERS = {
  "x-api-key": "970232e1-2000-4db2-be5a-4f6b59ca3315"
};
const String BASE_URL = "https://api.thecatapi.com/v1";

class CatsRepositoryImpl implements CatsRepository {
  
  static final CatsRepositoryImpl _singleton = new CatsRepositoryImpl._internal();

  factory CatsRepositoryImpl() {
    return _singleton;
  }

  CatsRepositoryImpl._internal();

  @override
  Future<List<CatImage>> fetchData(int page) async {
    final response = await http.get(
        '$BASE_URL/images/search?limit=${Constants.itemsCount}&page=$page',
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
