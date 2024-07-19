import 'package:dartz/dartz.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

/// Future<Either<Failure, NewsModel>> getPopularNews
abstract class NewsRepository {
  Future<Either<Failure, PopularNewsModel>> getPopularNews();

  // Future<Either<Failure, NewsModel>> searchTopHeadlinesNews(String keyword);
}


