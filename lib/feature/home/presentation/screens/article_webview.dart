import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_test/utils/my_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String articleUrl;
  final String articleName;
  const ArticleView(
      {super.key, required this.articleUrl, required this.articleName});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool _loading = true;
  late final WebViewController _controller;
  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.articleUrl.toString()))
      ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (_) => setState(() {
                _loading = false;
              })));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Test",
                style: TextStyle(
                  letterSpacing: -.5,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),

              GradientText("News",
                  style: const TextStyle(
                    letterSpacing: -.5,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  colors: MyTheme.gradientColors)
            ],
          ),
          centerTitle: true,
          elevation: .1,
          actions: [
            IconButton(
                onPressed: () async {
                  await Share.share(
                      'Read the article : ${widget.articleName}\n Link : ${widget.articleUrl}');
                },
                icon: const Icon(CupertinoIcons.share)),
            IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
          ],
          bottom:
              const PreferredSize(preferredSize: Size(0, 6), child: SizedBox()),
        ),
        body: Stack(children: [
          if (_loading)
            const Center(child: CircularProgressIndicator.adaptive()),
          WebViewWidget(controller: _controller)
        ]));
  }
}
