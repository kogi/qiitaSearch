import 'package:study_001/models/user.dart';

class Article{

  Article({
    required this.title,
    required this.user,
    this.likesCount = 0,
    this.tags = const [],
    required this.createdAt,
    required this.url,
  });

  final String title;
  final User user;
  final int likesCount;
  final List<String> tags;
  final DateTime createdAt;
  final String url;

  factory Article.resJson(dynamic json){
    return Article(
        title: json['title'] as String,
        user: User.resJson(json['user']),
        url: json['url'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        likesCount: json['likes_count'] as int,
        tags: (json['tags'] as List).map((tag) => tag['name'] as String).toList() ?? [],
    );
  }
}