import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:newsapi/const/const.dart';
import 'package:newsapi/news_model.dart';

class DetailsNewsPage extends StatelessWidget {
  const DetailsNewsPage({super.key, required this.articles});
  final Articles articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          articles.title.toString(),
          style: myStyle(20, Colors.black, FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              articles.title.toString(),
              style: myStyle(20, Colors.black, FontWeight.w700),
            ),
            SizedBox(height: 12),
            Text(
              articles.source!.name.toString(),
              style: myStyle(16, Colors.blue, FontWeight.w700),
            ),
            SizedBox(height: 8),
            Text(
              Jiffy(articles.publishedAt.toString())
                  .format('EEE MMM dd yyy h:mm a'),
              style: myStyle(12, Colors.black87, FontWeight.w400),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.network(articles.urlToImage.toString()),
            ),
            Text(
              articles.content.toString(),
              style: myStyle(16, Colors.black87, FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
