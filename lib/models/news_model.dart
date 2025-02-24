class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String content;

  NewsArticle({required this.title, required this.description, required this.urlToImage, required this.content});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? "No Title",
      description: json['description'] ?? "No Description",
      urlToImage: json['urlToImage'] ?? "",
      content: json['content'] ?? "No Content",
    );
  }
}
