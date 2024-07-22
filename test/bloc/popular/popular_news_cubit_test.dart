import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/core/network/network_info.dart';
import 'package:news_app_test/src/feature/home/domain/usecase/get_popular_news/get_popular_news.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/src/feature/home/presentation/cubit/popular_state.dart';

class MockGetPopularNews extends Mock implements GetPopularNews {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late PopularNewsCubit popularNewsCubit;
  late MockGetPopularNews mockGetPopularNews;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGetPopularNews = MockGetPopularNews();
    mockNetworkInfo = MockNetworkInfo();
    popularNewsCubit = PopularNewsCubit(
      getPopularNews: mockGetPopularNews,
      networkInfo: mockNetworkInfo,
    );
  });

  group('PopularNewsCubit', () {
    test('initial state is InitialPopularNewsState', () {
      expect(popularNewsCubit.state, InitialPopularNewsState());
    });

    blocTest<PopularNewsCubit, PopularNewsState>(
      'emits OfflineStatus when there is no internet connection',
      build: () {
        when(() => mockGetPopularNews()).thenAnswer(
          (_) async =>
              const Right(PopularNewsModel(results: [PopularNewsResult()])),
        );
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockNetworkInfo.isStreamConnected)
            .thenAnswer((_) => Stream.value(InternetStatus.disconnected));
        return popularNewsCubit;
      },
      act: (cubit) => cubit.loadPopularNewsData(),
      expect: () => [
        isA<LoadingPopularNewsState>(),
        isA<LoadedPopularNewsState>(),
        isA<OfflineStatus>(),
      ],
    );
  });
}
