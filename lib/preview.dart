import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/cat_image.dart';
import 'package:photo_view/photo_view.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({Key key, this.catImage}) : super(key: key);

  final CatImage catImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
            child: Hero(
                tag: catImage.id,
                child: PhotoView(
                  imageProvider: NetworkImage(catImage.url),
                ))),
      ),
    );
  }
}
