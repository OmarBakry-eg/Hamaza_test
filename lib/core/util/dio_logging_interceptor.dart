import 'package:dio/dio.dart';
import 'logger.dart';

class DioLoggingInterceptor extends InterceptorsWrapper {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    Logger.logNormal(
        "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
    Logger.logNormal('Headers:');
    options.headers.forEach((k, v) => Logger.logNormal('$k: $v'));
    if (options.queryParameters.isNotEmpty) {
      Logger.logNormal('queryParameters:');
      options.queryParameters.forEach((k, v) => Logger.logNormal('$k: $v'));
    }
    if (options.data != null) {
      Logger.logNormal('Body: ${options.data}');
    }
    Logger.logNormal('--> END ${options.method.toUpperCase()}');

    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    Logger.logNormal(
        "<-- ${response.statusCode} ${(response.requestOptions.baseUrl + response.requestOptions.path)}");
    Logger.logNormal('Headers:');
    response.headers.forEach((k, v) => Logger.logNormal('$k: $v'));
    Logger.logNormal('Response: ${response.data}');
    Logger.logNormal('<-- END HTTP');

    return handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    Logger.logNormal(
        "<-- ${err.message} ${(err.response?.requestOptions.baseUrl)}${(err.response?.requestOptions.path)}");
    Logger.logNormal(
        "${err.response != null ? err.response?.data : 'Unknown Error'}");
    Logger.logNormal('<-- End error');
    return handler.next(err);
  }
}
