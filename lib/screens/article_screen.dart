import 'package:flutter/material.dart';
import 'package:study_001/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late WebViewController controller = WebViewController()
    ..loadRequest(
      Uri.parse(widget.article.url),
    );

// @override
// void initState() {
//   super.initState();
//   if (WebViewPlatform.instance == null) {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       WebViewPlatform.instance = AndroidWebView();
//     } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//       WebViewPlatform.instance = WebKitWebView();
//     }
//   }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Article Page'),
    ),
    body: WebViewWidget(controller: controller),
  );
}
}
// }
