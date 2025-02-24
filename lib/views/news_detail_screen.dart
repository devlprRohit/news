import 'package:flutter/material.dart';

import '../models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle news;

  NewsDetailScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: news.title, child: Image.network(news.urlToImage, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(news.content, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
