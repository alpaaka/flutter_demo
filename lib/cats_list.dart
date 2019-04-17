import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/cat_image.dart';
import 'package:flutter_demo_app/preview.dart';

class CatsImagesList extends StatefulWidget {
  CatsImagesList({Key key, this.initialState}) : super(key: key);

  final List<CatImage> initialState;

  @override
  State<StatefulWidget> createState() => _CatsImagesListState();
}

class _CatsImagesListState extends State<CatsImagesList> {
  List<CatImage> list = new List();

  @override
  void initState() {
    list.addAll(widget.initialState);
    super.initState();
  }

  void _onTapped(BuildContext context, CatImage catImage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewPage(catImage: catImage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final CatImage catImage = list[index];
        return GestureDetector(
            child: Hero(tag: catImage.id, child: Image.network(catImage.url)),
            onTap: () => this._onTapped(context, catImage));
      },
    );
  }
}
