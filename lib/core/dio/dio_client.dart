import 'package:dio/dio.dart';
import 'package:news_app_test/core/dio/dio_exception.dart';
import 'package:news_app_test/core/network/network_info.dart';
import 'package:news_app_test/core/util/dio_logging_interceptor.dart';
import 'package:news_app_test/core/util/logger.dart';
import 'result.dart';

class DioClient {
  final NetworkInfo _networkInfo;
  DioClient(this._networkInfo);

  final Dio _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 120), // 120 seconds
      receiveTimeout: const Duration(seconds: 120), // 120 seconds
      headers: {'Accept': "application/json"},
      queryParameters: {
        'api-key': _APIKey.newsAPIKey,
      },
      baseUrl: BaseUrlConfig._baseUrl))
    ..interceptors.add(DioLoggingInterceptor());

  Future<Result> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    bool internetAvailale = await _networkInfo.isConnected;

    if (internetAvailale) {
      try {
        Response response = await _dio.get(
          endPoint,
          queryParameters: queryParameters,
        );

        return Result.success(response.data);
      } on DioException catch (error) {
        String errorMessage = DioExceptions.fromDioError(error,
                statusCode: error.response?.statusCode)
            .message;

        Logger.logError("Default err case sc : ${error.response?.statusCode}");
        Logger.logError("error $error");
        Logger.logError("error.message ${error.message}");

        return Result.error(errorMessage, error.response?.statusCode);
      }
    }
    return Result.networkError('No internet connection');
  }
}

mixin BaseUrlConfig {
  static const String _baseUrl = "https://api.nytimes.com/svc/";

  static const String popularNewsPath = "mostpopular/v2/viewed/1.json";

  /// Query parameter is q=
  static const String searchNewsPath = "search/v2/articlesearch.json";
}

mixin _APIKey {
  static const String newsAPIKey =
      'Ym9nP2LOtrP1BovNTGmnB90vW8OaNM0Z'; //! move to ENV
}
