import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_app/cat_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final CatImage catImage = list[index];
        return Image.network(
            catImage.url
        );
      },
    );
  }
}
