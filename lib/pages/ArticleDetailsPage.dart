import 'package:bloc_json/models/api_model.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final Articles article;
  ArticleDetailPage({this.article});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Detail"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          Hero(
            tag: article.urlToImage,
            child: Image.network(article.urlToImage),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: Text(
              article.title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(5.0),
            child: Text(article.publishedAt),
          ),
          Text(article.content.toString())
        ],
      ),
    );
  }
}
