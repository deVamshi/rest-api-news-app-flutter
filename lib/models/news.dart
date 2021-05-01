import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
  News({
    this.newsId,
    this.name,
    this.url,
  });

  String newsId;
  String name;
  String url;

  factory News.fromJson(Map<String, dynamic> json) => News(
        newsId: json["news_id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "name": name,
        "url": url,
      };
}
