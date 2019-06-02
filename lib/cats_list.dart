import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_app/cat_image.dart';
import 'package:flutter_demo_app/cats_list_repository_impl.dart';
import 'package:flutter_demo_app/constants.dart';
import 'package:flutter_demo_app/preview.dart';

class CatsImagesList extends StatefulWidget {
  CatsImagesList({Key key, this.initialState}) : super(key: key);

  final List<CatImage> initialState;

  @override
  State<StatefulWidget> createState() => _CatsImagesListState();
}

class _CatsImagesListState extends State<CatsImagesList> {
  CatsRepositoryImpl catsRepository = CatsRepositoryImpl();

  List<CatImage> list = new List();
  ScrollController _controller;
  var pageNumber = 0;
  var isLoading = false;

  @override
  void initState() {
    list.addAll(widget.initialState);

    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  void _onTapped(BuildContext context, CatImage catImage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewPage(catImage: catImage)),
    );
  }

  _scrollListener() {
    if (_controller.position.maxScrollExtent == _controller.offset) {
      if (list.length >= (Constants.itemsCount * pageNumber) && !isLoading) {
        isLoading = true;
        pageNumber++;
        catsRepository.fetchData(pageNumber).then((result) => this.setState(() {
              isLoading = false;
              list.addAll(result);
            }));
      }
    }
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
      controller: _controller,
    );
  }
}
