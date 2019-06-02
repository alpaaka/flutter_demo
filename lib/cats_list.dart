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
      /***
       * we need to get new data on page scroll end but if the last
       * time when data is returned, its count should be Constants.itemsCount' (10)
       *
       * So we calculate every time
       *
       * productList.length >= (Constants.itemsCount*pageNumber)
       *
       * list must contain the products == Constants.itemsCount if the page number is 1
       * but if page number is increased then we need to calculate the total
       * number of products we have received till now example:
       * first time on page scroll if last count of productList is Constants.itemsCount
       * then increase the page number and get new data.
       * Now page number is 2, now we have to check the count of the productList
       * if it is==Constants.itemsCount*pageNumber (20 in current case) then we have
       * to get data again, if not then we assume, server has not more data then
       * we currently have.
       *
       */
      if (list.length >= (Constants.itemsCount * pageNumber) && !isLoading) {
        isLoading = true;
        pageNumber++;
        FutureBuilder<List<CatImage>>(
            future: catsRepository.fetchData(pageNumber),
            builder: (context, snapshot) {
              isLoading = false;
              if (snapshot.hasData) {
                list.addAll(snapshot.data);
              }
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Row(
              children: <Widget>[
                new ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final CatImage catImage = list[index];
                    return GestureDetector(
                        child: Hero(
                            tag: catImage.id,
                            child: Image.network(catImage.url)),
                        onTap: () => this._onTapped(context, catImage));
                  },
                  controller: _controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
