import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_001/models/article.dart';
import 'package:study_001/widget/article_container.dart';
import 'package:study_001/models/user.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article> articles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'Input keywords',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value); // ← 検索処理を実行する
                setState(() => articles = results);
              },
            ),
          ),
          Expanded(
              child: ListView(
                children: articles.map((article) => ArticleContainer(article: article)).toList()
              )
          
          )
          // ArticleContainer(
          //   article: Article(
          //     title: 'test,test,test,test,test,test,test,test,test,test,test,test,',
          //     user: User(
          //       id:'admin',
          //       profileImageUrl: 'https://static.zenn.studio/images/logo-transparent.png',
          //     ),
          //     createdAt: DateTime.now(),
          //     tags: ['Flutter','dart','hello world'],
          //     url: 'https://takeyou.net',
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備をする
    // 2. Qiita APIにリクエストを送る
    // 3. 戻り値をArticleクラスの配列に変換
    // 4. 変換したArticleクラスの配列を返す(returnする)


    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': '10',
    });

    if (kDebugMode) {
      print(uri.toString());
    }

    const String token = '86ef1c87f20c1b8940aadb79efd5eb3ad1be56cf';

    print(token);

    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token'
    });

    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      print(body[0]['title'].toString());
      return body.map((dynamic json) => Article.resJson(json)).toList();
    } else {
      return [];
    }
  }

}