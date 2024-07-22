import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/home/data/datasource/local/news_local_source.dart';
import 'package:news_app_test/src/feature/home/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/src/feature/home/data/repository/news_repository_impl.dart';

class MockNewsRemoteDataSource extends Mock implements NewsRemoteDataSource {}
class MockPopularNewsLocalSource extends Mock implements PopularNewsLocalSource {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PopularNewsRepositoryImpl repository;
  late MockNewsRemoteDataSource mockNewsRemoteDataSource;
  late MockPopularNewsLocalSource mockPopularNewsLocalSource;

  setUp(() {
    mockNewsRemoteDataSource = MockNewsRemoteDataSource();
    mockPopularNewsLocalSource = MockPopularNewsLocalSource();
    repository = PopularNewsRepositoryImpl(
      newsRemoteDataSource: mockNewsRemoteDataSource,
      newsLocalSource: mockPopularNewsLocalSource,
    );
  });

  group('getPopularNews', () {
    final List<PopularNewsResult> tPopularNewsResults = [
      const PopularNewsResult(title: 'Test News 1', url: 'Content 1'),
      const PopularNewsResult( title: 'Test News 2', url: 'Content 2'),
    ];
    final PopularNewsModel tPopularNewsModel = PopularNewsModel(results: tPopularNewsResults);
    setUp(() {
      // Arrange the `addItem` method to return a Future<void>
      when(() => mockPopularNewsLocalSource.addItem(any())).thenAnswer((_) async => Future.value());
    });

    test('should return remote data when the call to remote data source is successful', () async {
      // Arrange
      when(() => mockNewsRemoteDataSource.getPopularNews())
          .thenAnswer((_) async => tPopularNewsModel);
      // Act
      final result = await repository.getPopularNews();
      // Assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      expect(result, equals(Right(tPopularNewsModel)));
    });

    test('should cache the data locally when the call to remote data source is successful', () async {
      // Arrange
      when(() => mockNewsRemoteDataSource.getPopularNews())
          .thenAnswer((_) async => tPopularNewsModel);
      // Act
      await repository.getPopularNews();
      // Assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      verify(() => mockPopularNewsLocalSource.addItem(tPopularNewsResults));
    });
    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(() => mockNewsRemoteDataSource.getPopularNews()).thenThrow(ServerException(message: 'Server Error'));
      // act
      final result = await repository.getPopularNews();
      // assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      expect(result, equals(const Left(ServerFailure(message: 'Server Error'))));
    });

    test('should return cached data when device is offline and data is present in cache', () async {
      // arrange
      when(() => mockNewsRemoteDataSource.getPopularNews()).thenThrow(const OfflineException(message: 'Offline'));
      when(() => mockPopularNewsLocalSource.getItem()).thenAnswer((_) async => tPopularNewsResults);
      // act
      final result = await repository.getPopularNews();
      // assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      verify(() => mockPopularNewsLocalSource.getItem());
      expect(result, equals(Right(tPopularNewsModel)));
    });

    test('should return OfflineFailure when device is offline and no data is present in cache', () async {
      // arrange
      when(() => mockNewsRemoteDataSource.getPopularNews()).thenThrow(const OfflineException(message: 'Offline'));
      when(() => mockPopularNewsLocalSource.getItem()).thenAnswer((_) async => []);
      // act
      final result = await repository.getPopularNews();
      // assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      verify(() => mockPopularNewsLocalSource.getItem());
      expect(result, equals(const Left(OfflineFailure(message: 'Offline'))));
    });

    test('should return EmptyCacheFailure when there is no data in cache', () async {
      // arrange
      when(() => mockNewsRemoteDataSource.getPopularNews()).thenThrow(const EmptyCacheException(message: 'No Cache'));
      // act
      final result = await repository.getPopularNews();
      // assert
      verify(() => mockNewsRemoteDataSource.getPopularNews());
      expect(result, equals(const Left(EmptyCacheFailure(message: 'No Cache'))));
    });
  });
}
