import 'package:news_app_test/core/dio/dio_client.dart';
import 'package:news_app_test/core/network/network_info.dart';
import 'package:news_app_test/feature/home/data/datasource/news/news_remote_data_source.dart';
import 'package:news_app_test/feature/home/data/repository/news_repository_impl.dart';
import 'package:news_app_test/feature/home/domain/repository/news/news_repository.dart';
import 'package:news_app_test/feature/home/domain/usecase/get_popular_news/get_popular_news.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(
    () => PopularNewsCubit(
      getPopularNews: sl(),
    ),
  );

  // Use Case
  sl.registerLazySingleton(() => GetPopularNews(newsRepository: sl()));
  // sl.registerLazySingleton(() => SearchTopHeadlinesNews(newsRepository: sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
      () => PopularNewsRepositoryImpl(newsRemoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(sl()));

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() => DioClient(sl()));

  sl.registerLazySingleton(() => InternetConnection());
}
