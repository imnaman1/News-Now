import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/constant.dart';

class Backend {
  const Backend({required this.hostUrl});

  final String hostUrl;

  Future<List<News>> getNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=$apikey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final body = response.body;

    List<dynamic> jsonData = jsonDecode(body)['articles'];

    final news = jsonData.map((jsonData) {
      return News(
        id: jsonData['id'],
        title: jsonData['title'],
        description: jsonData['description'],
        urltoImage: jsonData['urlToImage'],
        url: jsonData['url'],
      );
    }).toList();

    return news;
  }
}

class CategoryNews {
  List<News> newsList = [];
  Future<void> getNewsForCategory(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apikey";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          News article = News(
            title: element['title'],
            id: element['id'],
            description: element['description'],
            urltoImage: element['urlToImage'],
            url: element["url"],
          );
          newsList.add(article);
        }
      });
    }
  }
}

class News {
  const News(
      {required this.title,
      required this.url,
      required this.id,
      required this.description,
      this.urltoImage});

  final String title;
  final String? id;
  final String? url;
  final String? description;
  final String? urltoImage;
}
