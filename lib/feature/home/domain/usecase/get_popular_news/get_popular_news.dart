import 'package:dartz/dartz.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/feature/home/domain/repository/news/news_repository.dart';

class GetPopularNews {
  final NewsRepository newsRepository;

  const GetPopularNews({required this.newsRepository});

  Future<Either<Failure, PopularNewsModel>> call() async =>
      await newsRepository.getPopularNews();
}
