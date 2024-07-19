import 'package:dartz/dartz.dart';
import 'package:news_app_test/core/errors/exceptions.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/home/data/datasource/news/news_remote_data_source.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/feature/home/domain/repository/news/news_repository.dart';

class PopularNewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;

  const PopularNewsRepositoryImpl({
    required this.newsRemoteDataSource,
  });

  @override
  Future<Either<Failure, PopularNewsModel>> getPopularNews() async {
    try {
      PopularNewsModel newsModel = await newsRemoteDataSource.getPopularNews();
      return Right(newsModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(OfflineFailure(message: e.message));
    } on EmptyCacheException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    }
  }
}
