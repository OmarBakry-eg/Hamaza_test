import 'package:flutter/material.dart';
import 'package:news_app_test/src/feature/home/presentation/widgets/article_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String articleUrl;
  final String articleName;
  const ArticleWebView(
      {super.key, required this.articleUrl, required this.articleName});

  @override
  State<ArticleWebView> createState() => ArticleWebViewState();
}

class ArticleWebViewState extends State<ArticleWebView> {
  late final WebViewController _controller;
  @override
  void didChangeDependencies() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white)
      ..loadRequest(Uri.parse(widget.articleUrl.toString()));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ArticleAppBarWidget(
          articleName: widget.articleName,
          articleUrl: widget.articleUrl,
        ),
        body: WebViewWidget(controller: _controller));
  }
}
