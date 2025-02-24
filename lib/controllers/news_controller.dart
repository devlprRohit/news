import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var newsList = <NewsArticle>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=d7f3d9a5d6434551889a757fee0568b6'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        newsList.value = (jsonData['articles'] as List).map((data) => NewsArticle.fromJson(data)).toList();
      }
    } catch (e) {
      print("Error fetching news: $e");
    } finally {
      isLoading(false);
    }
  }

  void searchNews(String query) {
    searchQuery.value = query;
  }
}
