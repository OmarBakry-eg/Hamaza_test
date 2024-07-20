import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/feature/home/presentation/screens/article_webview.dart';
import 'package:news_app_test/feature/home/presentation/widgets/article_appbar.dart';
import 'package:news_app_test/utils/my_theme.dart';

class ArticlePage extends StatelessWidget {
  final PopularNewsResult article;
  const ArticlePage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArticleAppBarWidget(
          articleUrl: article.url ?? "", articleName: article.title ?? ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? "",
                  style: MyTheme.displayMedium,
                ),
                Text(
                  DateFormat.yMEd()
                      .format(article.publishedDate ?? DateTime.now()),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Wrap(
                  children: [
                    for (String? tag in article.desFacet ?? []) ...{
                      if (tag != null) ...{
                        Tag(tag: tag, defaultSelected: true),
                      }
                    }
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: article.largeImage != null
                      ? CachedNetworkImage(
                          imageUrl: article.largeImage!,
                          filterQuality: FilterQuality.high,
                          placeholder: (context, _) {
                            return Container(
                                color: Colors.black12,
                                child: LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.black54, size: 30));
                          },
                          errorWidget: (context, error, stackTrace) {
                            return const Icon(Icons.error_outline, size: 40);
                          },
                        )
                      : const Icon(Icons.photo, size: 40),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(article.resultAbstract ?? ""),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 23,
                ),
                if (article.url != null) ...{
                  Center(
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleWebView(
                                        articleUrl: article.url!,
                                        articleName:
                                            article.title ?? "Unknown title",
                                      )));
                        },
                        child: const Text(
                          "View Full Article",
                        )),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final String tag;
  final bool? defaultSelected;
  final Function()? onTap;

  const Tag({super.key, required this.tag, this.onTap, this.defaultSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          label: Text(
            tag,
          ),
        ),
      ),
    );
  }
}
