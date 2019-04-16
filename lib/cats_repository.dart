import 'package:flutter_demo_app/cat_image.dart';

abstract class CatsRepository {
  Future<List<CatImage>> fetchData(int page);
}
