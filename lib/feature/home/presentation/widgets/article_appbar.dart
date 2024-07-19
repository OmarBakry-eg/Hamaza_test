import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app_test/utils/my_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ArticleAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ArticleAppBarWidget(
      {super.key, required this.articleUrl, required this.articleName});

  final String articleUrl;
  final String articleName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Hamzah ",
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
                  'Read the article from hamaza test : $articleName\n Link : $articleUrl');
            },
            icon: const Icon(CupertinoIcons.share)),
      ],
      bottom: const PreferredSize(preferredSize: Size(0, 6), child: SizedBox()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
