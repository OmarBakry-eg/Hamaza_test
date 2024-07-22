import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app_test/src/utils/constants.dart';
import 'package:share_plus/share_plus.dart';

class ArticleAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ArticleAppBarWidget(
      {super.key, required this.articleUrl, required this.articleName});

  final String articleUrl;
  final String articleName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const HamzahNewsTitle(),
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
      bottom: const PreferredSize(preferredSize: Size(0, 6), child: SizedBox.shrink()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
