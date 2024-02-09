import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/news/news_model.dart';
import 'detail_new/detail_new_screen.dart';

class NewsCard extends StatefulWidget {
  final List<String> imagesURL;
  final DateTime publishedDate;
  final String title;
  final String description;
  final List<NewsModel> newsList;
  final int index;
  final NewsModel  newsModel;
   const NewsCard(
      this.imagesURL, this.publishedDate, this.title, this.description, this.newsList, this.index,
       this.newsModel)
      : super();

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: imageCarousel(),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 13),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Fecha de publicación: ${DateFormat.yMd().add_jm().format(widget.publishedDate)}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                           
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailNewScreen(
                                        widget.newsModel
                                      )));
                          },

                          child: const Text("Leer más"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openNewsScreen() {}

  Widget imageCarousel() {
    return PageView.builder(
      itemCount: widget.imagesURL.length,
      pageSnapping: true,
      itemBuilder: (context, pagePosition) {
        return Image.network(
          widget.imagesURL[pagePosition],
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Row _dotIndicators() {
    Row dotRow = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _getDots(),
    );

    return dotRow;
  }

  List<Widget> _getDots() {
    List<Widget> dotIndicators = [];

    for (var i = 0; i < widget.imagesURL.length; i++) {
      Padding dot = _dot(i == selectedPage);
      dotIndicators.add(dot);
    }

    return dotIndicators;
  }

  Padding _dot(bool isSelectedDot) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelectedDot
                ? Theme.of(context).hintColor
                : Theme.of(context).focusColor,
          ),
        ),
      );
}
