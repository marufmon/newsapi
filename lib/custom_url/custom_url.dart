import 'dart:convert';
import 'package:newsapi/const/const.dart';
import 'package:newsapi/news_model.dart';
import 'package:http/http.dart';

class CustomUrl {
  Future<List<Articles>> fetchAllNewsData(
      {required String pageNo, required String sortBy}) async {
    List<Articles> allNewsData = [];
    Articles articles;

    var response = await get(Uri.parse(
        "$baseUrl?q=bitcoin&page=$pageNo&pageSize=10&sortBy=$sortBy&apiKey=$api"));
    print(response.statusCode.toString());
    var data = jsonDecode(response.body);
    for (var i in data['articles']) {
      articles = Articles.fromJson(i);
      allNewsData.add(articles);
    }

    return allNewsData;
  }
}
