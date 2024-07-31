import 'package:flutter/material.dart';
import 'package:study_001/models/article.dart';
import 'package:intl/intl.dart';
import 'package:study_001/screens/article_screen.dart';

class ArticleContainer extends StatelessWidget {
  const ArticleContainer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => ArticleScreen(article: article))));
            },
            child: Container(
              height: 190,
              padding: const EdgeInsets.symmetric(
                // ← 内側の余白を指定
                horizontal: 20,
                vertical: 16,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF55C500), // ← 背景色を指定
                borderRadius: BorderRadius.all(
                  Radius.circular(32), // ← 角丸を設定
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat('yyyy/MM/dd').format(article.createdAt),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '#${article.tags.join(' #').toString()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            Text(
                              article.likesCount.toString(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundImage:
                                    NetworkImage(article.user.profileImageUrl),
                              ),
                              const SizedBox(height: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    article.user.id,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      ])
                ],
              ),
            )));
  }
}
