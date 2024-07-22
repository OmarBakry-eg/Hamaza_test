import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/core/dio/dio_client.dart';
import 'package:news_app_test/src/core/dio/result.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';
import 'package:news_app_test/src/feature/home/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late NewsRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    dataSource = NewsRemoteDataSourceImpl(mockDioClient);
  });

  group('getPopularNews', () {
    const Map<String, dynamic> tPopularNewsJson = {};
    final tPopularNewsModel = PopularNewsModel.fromJson(tPopularNewsJson);

    test(
        'should return PopularNewsModel when the response code is 200 (success)',
        () async {
      // Arrange
      when(() => mockDioClient.get(any()))
          .thenAnswer((_) async => SuccessState(tPopularNewsJson));

      // Act
      final result = await dataSource.getPopularNews();

      // Assert
      verify(() => mockDioClient.get(BaseUrlConfig.popularNewsPath));
      expect(result, equals(tPopularNewsModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other server error',
        () async {
      // Arrange
      when(() => mockDioClient.get(any()))
          .thenAnswer((_) async => ErrorState('Server Error', 404));

      // Act
      final call = dataSource.getPopularNews;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });

    test('should throw an OfflineException when there is a network error',
        () async {
      // Arrange
      when(() => mockDioClient.get(any()))
          .thenAnswer((_) async => NetworkErrorState('Network Error'));

      // Act
      final call = dataSource.getPopularNews;

      // Assert
      expect(() => call(), throwsA(isA<OfflineException>()));
    });

    test('should throw a ServerException for unknown errors', () async {
      // Arrange
      when(() => mockDioClient.get(any())).thenAnswer((_) async => Result.error(
          'ServerException', 500)); // Returning an unexpected Result type

      // Act
      final call = dataSource.getPopularNews;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
