import 'package:equatable/equatable.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

abstract class PopularNewsState extends Equatable {
  const PopularNewsState();

  @override
  List<Object> get props => [];
}

class InitialPopularNewsState extends PopularNewsState {}

class LoadingPopularNewsState extends PopularNewsState {}

class LoadedPopularNewsState extends PopularNewsState {
  final List<PopularNewsResult> articleList;

  const LoadedPopularNewsState({required this.articleList});

  @override
  List<Object> get props => [articleList];

  @override
  String toString() {
    return 'LoadedPopularNewsState{listArticles: $articleList}';
  }
}

class FailurePopularNewsState extends PopularNewsState {
  final String errorMessage;

  const FailurePopularNewsState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];

  @override
  String toString() {
    return 'FailurePopularNewsState{errorMessage: $errorMessage}';
  }
}


class SearchSuccessPopularNewsState extends PopularNewsState {
  final List<PopularNewsResult> listArticles;

  const SearchSuccessPopularNewsState({required this.listArticles});

  @override
  List<Object> get props => [listArticles];

  @override
  String toString() {
    return 'SearchSuccessPopularNewsState{listArticles: $listArticles}';
  }
}
