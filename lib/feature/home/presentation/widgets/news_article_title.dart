import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/feature/home/presentation/screens/article_page.dart';
import 'package:news_app_test/feature/home/presentation/widgets/read_more_button.dart';
import 'package:news_app_test/utils/my_theme.dart';

class NewsArticleTile extends StatelessWidget {
  final PopularNewsResult result;

  const NewsArticleTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 23, left: 3, right: 3),
      child: Column(
        children: [
          Row(
            children: [
              // Left part: Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: result.largeImage != null
                    ? CachedNetworkImage(
                        imageUrl: result.largeImage!,
                        width: 118,
                        height: 118,
                        fit: BoxFit.cover,
                        placeholder: (context, _) {
                          return Container(
                              color: Colors.black12,
                              width: 118,
                              height: 118,
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: Colors.black54, size: 30));
                        },
                        errorWidget: (context, error, stackTrace) {
                          return const SizedBox(
                            width: 118,
                            height: 118,
                            child: Icon(Icons.error_outline, size: 40),
                          );
                        },
                      )
                    : const SizedBox(
                        height: 118,
                        width: 118,
                        child: Icon(Icons.photo, size: 40),
                      ),
              ),
              const SizedBox(width: 15),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author and uploading date
                    Text(
                      result.byline != null && result.publishedDate != null
                          ? "${result.byline!.length > 15 ? result.byline!.substring(0, 15) : result.byline}... ${DateFormat.yMd().format(result.publishedDate!)}"
                          : "Source unknown",
                      style: MyTheme.displaySmall,
                    ),

                    const SizedBox(height: 3),

                    // Title of the article
                    Text(
                      result.title ?? "",
                      maxLines: 3,
                      style: MyTheme.displayMedium,
                    ),

                    const SizedBox(height: 10),

                    if (result.url != null) ...{
                      HelperButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticlePage(
                                        article: result,
                                      )));
                        },
                      ),
                    }
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 23,
          ),
        ],
      ),
    );
  }
}
