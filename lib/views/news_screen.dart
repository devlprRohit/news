import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'news_detail_screen.dart';

class NewsScreen extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News App")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(hintText: "Search News", border: OutlineInputBorder()),
              onChanged: newsController.searchNews,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (newsController.isLoading.value) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (_, __) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListTile(
                      leading: CircleAvatar(radius: 30, backgroundColor: Colors.white),
                      title: Container(height: 10, color: Colors.white),
                      subtitle: Container(height: 10, color: Colors.white),
                    ),
                  ),
                );
              }

              var filteredList = newsController.newsList.where((news) =>
                  news.title.toLowerCase().contains(newsController.searchQuery.value.toLowerCase())).toList();

              return ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var news = filteredList[index];
                  return Dismissible(
                    background: Container(
                      child: Center(
                        child: Icon(FontAwesomeIcons.xmark),
                      ),
                      color: Colors.red,
                    ),
                    key: Key(news.title),
                    onDismissed: (direction) => newsController.newsList.removeAt(index),
                    child: ListTile(
                      leading: Hero(
                        tag: news.title,
                        child: Image.network(news.urlToImage, width: 80, height: 80, fit: BoxFit.cover),
                      ),
                      title: Text(news.title),
                      subtitle: Text(news.description, maxLines: 2),
                      onTap: () => Get.to(() => NewsDetailScreen(news: news)),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
