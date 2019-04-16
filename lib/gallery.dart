import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/cat_image.dart';
import 'package:flutter_demo_app/cats_list.dart';
import 'package:flutter_demo_app/cats_list_repository_impl.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  CatsRepositoryImpl catsRepository = CatsRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<List<CatImage>>(
          future: catsRepository.fetchData(15),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CatsImagesList(
                initialState: snapshot.data
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
