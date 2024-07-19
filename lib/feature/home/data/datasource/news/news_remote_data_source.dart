import 'package:news_app_test/core/dio/dio_client.dart';
import 'package:news_app_test/core/dio/result.dart';
import 'package:news_app_test/core/errors/exceptions.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

abstract class NewsRemoteDataSource {
  Future<PopularNewsModel> getPopularNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final DioClient _dio;

  const NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<PopularNewsModel> getPopularNews() async {
    Result result = await _dio.get(BaseUrlConfig.popularNewsPath);
    if (result is SuccessState) {
      return PopularNewsModel.fromJson(result.value);
    } else if (result is ErrorState) {
      throw ServerException(
        message: result.msg.toString(),
      );
    } else if (result is NetworkErrorState) {
      throw OfflineException(message: result.msg.toString());
    } else {
      throw ServerException(
        message: "Unknown Error",
      );
    }
  }
}
