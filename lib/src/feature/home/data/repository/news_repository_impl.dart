import 'package:dartz/dartz.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/home/data/datasource/local/news_local_source.dart';
import 'package:news_app_test/src/feature/home/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/src/feature/home/domain/repository/news/news_repository.dart';

class PopularNewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final PopularNewsLocalSource newsLocalSource;

  const PopularNewsRepositoryImpl(
      {required this.newsRemoteDataSource, required this.newsLocalSource});

  @override
  Future<Either<Failure, PopularNewsModel>> getPopularNews() async {
    try {
      PopularNewsModel newsModel = await newsRemoteDataSource.getPopularNews();
      newsLocalSource.addItem(newsModel.results);
      return Right(newsModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on OfflineException catch (e) {
      List<dynamic>? results =
          await newsLocalSource.getItem();
      if (results != null && results.isNotEmpty) {
        List<PopularNewsResult> popRes = [];
        for (var element in results) {
          popRes.add(element);
        }
        PopularNewsModel newsModel = PopularNewsModel(results: popRes);
        return Right(newsModel);
      }
      return Left(OfflineFailure(message: e.message));
    } on EmptyCacheException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    }
  }
}
