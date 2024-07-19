import 'package:equatable/equatable.dart';
import 'package:news_app_test/feature/home/data/model/popular_model/popular_model.dart';

abstract class PopularNewsState extends Equatable {
  
final List<PopularNewsResult>? articleList;

  const PopularNewsState({this.articleList});

  @override
  List<Object> get props => [if(articleList != null) articleList!];

  @override
  String toString() {
    return 'PopularNewsState{listArticles: $articleList}';
  }
}

class InitialPopularNewsState extends PopularNewsState {}

class OnlineStatus extends PopularNewsState {
  const OnlineStatus({super.articleList});
  @override
  String toString() {
    return 'OnlineStatus{listArticles: $articleList}';
  }
}

class OfflineStatus extends PopularNewsState {
  const OfflineStatus({super.articleList});

  @override
  String toString() {
    return 'OfflineStatus{listArticles: $articleList}';
  }
}

class LoadingPopularNewsState extends PopularNewsState {}

class LoadedPopularNewsState extends PopularNewsState {
  const LoadedPopularNewsState({super.articleList});

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
