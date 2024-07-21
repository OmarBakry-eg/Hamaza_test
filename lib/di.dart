import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news_app_test/core/dio/dio_client.dart';
import 'package:news_app_test/core/hive/hive_services.dart';
import 'package:news_app_test/core/network/network_info.dart';
import 'package:news_app_test/feature/home/data/datasource/local/news_local_source.dart';
import 'package:news_app_test/feature/home/data/datasource/remote/news_remote_data_source.dart';
import 'package:news_app_test/feature/home/data/repository/news_repository_impl.dart';
import 'package:news_app_test/feature/home/domain/repository/news/news_repository.dart';
import 'package:news_app_test/feature/home/domain/usecase/get_popular_news/get_popular_news.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_app_test/feature/home/presentation/cubit/popular_cubit.dart';
import 'package:news_app_test/feature/login/data/repository/repo.dart';
import 'package:news_app_test/feature/login/data/source/local/local_source.dart';
import 'package:news_app_test/feature/login/data/source/remote/remote_source.dart';
import 'package:news_app_test/feature/login/domain/repository/auth_repo.dart';
import 'package:news_app_test/feature/login/domain/usecase/biometric_usecase.dart';
import 'package:news_app_test/feature/login/domain/usecase/delete_account_usecase.dart';
import 'package:news_app_test/feature/login/domain/usecase/save_user_data.dart';
import 'package:news_app_test/feature/login/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerFactory(
    () => PopularNewsCubit(getPopularNews: sl(), networkInfo: sl()),
  );

  sl.registerFactory(() => AuthCubit(
      deleteAccount: sl(), biometricUsecase: sl(), saveUserData: sl()));

  // Use Case
  sl.registerLazySingleton(() => GetPopularNews(newsRepository: sl()));
  sl.registerLazySingleton(() => DeleteAccount(authRepository: sl()));
  sl.registerLazySingleton(() => BiometricUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => SaveUserData(authRepository: sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(() => PopularNewsRepositoryImpl(
      newsRemoteDataSource: sl(), newsLocalSource: sl()));

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl()));

  // Remote Data Source
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<AuthenticationClient>(() => AuthRemoteSource());

  // Local Data Source
  sl.registerLazySingleton<PopularNewsLocalSource>(
      () => PopularNewsLocalSource());

  sl.registerLazySingleton<AuthStorage>(
      () => AuthLocalSource(secureStorage: sl()));
  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() => DioClient(sl()));

  sl.registerLazySingleton(() => InternetConnection());

  /**
   * ! Hive
   */
  await HiveService.initHive();

  /**
   * ! Secure Storage
   */
  const FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock));

  sl.registerLazySingleton(() => storage);

  /**
   * ! Firebase
   */
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
}
