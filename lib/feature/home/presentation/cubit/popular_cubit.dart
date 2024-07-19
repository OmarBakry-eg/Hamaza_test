import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/core/util/logger.dart';
import 'package:news_app_test/feature/home/domain/usecase/get_popular_news/get_popular_news.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

import 'popular_state.dart';

class PopularNewsCubit extends Cubit<PopularNewsState> {
  final GetPopularNews _getPopularNews;
// final SearchPopularNews? searchPopularNews;

  PopularNewsCubit({
    required GetPopularNews getPopularNews,
    //   this.searchPopularNews,
  })  : _getPopularNews = getPopularNews,
        super(InitialPopularNewsState());

  void loadPopularNewsEvent() {
    _mapLoadPopularNewsEventToState();
  }

  // void changeCategoryPopularNewsEvent(
  //  // ChangeCategoryPopularNewsEvent event,
  // ) {
  //   _mapChangeCategoryPopularNewsEventToState(event);
  // }

  void _mapLoadPopularNewsEventToState(
      // LoadPopularNewsEvent event
      ) async {
    emit(LoadingPopularNewsState());
    Logger.logNormal("Before");
    Either<Failure, PopularNewsModel> response = await _getPopularNews();
    Logger.logNormal("After");
    emit(response.fold(
      (failure) {
        if (failure is ServerFailure) {
          return FailurePopularNewsState(errorMessage: failure.message);
        } else if (failure is OfflineFailure) {
          return FailurePopularNewsState(errorMessage: failure.message);
        }
        return FailurePopularNewsState(
          errorMessage: failure.toString(),
        ); //! Error
      },
      (data) => LoadedPopularNewsState(articleList: data.results ?? []),
    ));
  }

  // void _mapChangeCategoryPopularNewsEventToState(
  //   ChangeCategoryPopularNewsEvent event,
  // ) {
  //   emit(ChangedCategoryPopularNewsState(
  //       indexCategorySelected: event.indexCategorySelected));
  // }

  // void searchPopularNewsEvent(SearchPopularNewsEvent event) {
  //   _mapSearchPopularNewsEventToState(event);
  // }

  // void _mapSearchPopularNewsEventToState(
  //     SearchPopularNewsEvent event) async {
  //   emit(LoadingPopularNewsState());
  //   var result = await searchPopularNews!(
  //       ParamsSearchPopularNews(keyword: event.keyword));
  //   emit(result.fold(
  //     // ignore: missing_return
  //     (failure) {
  //       if (failure is ServerFailure) {
  //         return FailurePopularNewsState(
  //             errorMessage: failure.errorMessage);
  //       } else if (failure is ConnectionFailure) {
  //         return FailurePopularNewsState(
  //             errorMessage: failure.errorMessage);
  //       }
  //       return FailurePopularNewsState(errorMessage: failure.toString());
  //     },
  //     (response) =>
  //         SearchSuccessPopularNewsState(listArticles: response.results),
  //   ));
  // }
}
