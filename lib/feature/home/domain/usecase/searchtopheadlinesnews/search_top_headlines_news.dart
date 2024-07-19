// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:news_app_test/core/error/failure.dart';
// import 'package:news_app_test/feature/domain/repository/news/news_repository.dart';
// import 'package:news_app_test/core/usecase/usecase.dart';
// import 'package:news_app_test/feature/data/model/popular_model/popular_model.dart';

// class SearchTopHeadlinesNews
//     implements UseCase<NewsModel, ParamsSearchTopHeadlinesNews> {
//   final NewsRepository newsRepository;

//   SearchTopHeadlinesNews({required this.newsRepository});

//   @override
//   Future<Either<Failure, NewsModel>> call(
//       ParamsSearchTopHeadlinesNews params) async {
//     return await newsRepository.searchTopHeadlinesNews(params.keyword);
//   }
// }

// class ParamsSearchTopHeadlinesNews extends Equatable {
//   final String keyword;

//   const ParamsSearchTopHeadlinesNews({required this.keyword});

//   @override
//   List<Object> get props => [keyword];

//   @override
//   String toString() {
//     return 'ParamsSearchTopHeadlinesNews{keyword: $keyword}';
//   }
// }
