import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/core/network/network_info.dart';
import 'package:news_app_test/src/core/loggers/logger.dart';
import 'package:news_app_test/src/feature/home/domain/usecase/get_popular_news/get_popular_news.dart';
import 'package:news_app_test/src/feature/home/data/model/popular_model/popular_model.dart';
import 'package:news_app_test/src/utils/constants.dart' as consts;
import 'popular_state.dart';

class PopularNewsCubit extends Cubit<PopularNewsState> {
  final GetPopularNews _getPopularNews;
  final NetworkInfo _networkInfo;

  PopularNewsCubit({
    required GetPopularNews getPopularNews,
    required NetworkInfo networkInfo,
  })  : _getPopularNews = getPopularNews,
        _networkInfo = networkInfo,
        super(InitialPopularNewsState());
  final List<PopularNewsResult> _articleList = [];
  void loadPopularNewsData() async {
    await _mapLoadPopularNewsEventToState();
    if (await _networkInfo.isConnected) {
      _prevStatus = null;
    } else {
      if (_articleList.isNotEmpty) {
        emit(OfflineStatus(articleList: _articleList));
      }
    }
    _listenToNetworkConnection();
  }

  InternetStatus? _prevStatus;
  void _listenToNetworkConnection() {
    _networkInfo.isStreamConnected.listen((InternetStatus status) {
      if (status == InternetStatus.connected && _prevStatus != null) {
        if (_articleList.isNotEmpty) {
          emit(OnlineStatus(articleList: _articleList));
        }
        if (!Platform.environment.containsKey('FLUTTER_TEST')) {
          consts.showToast("Back Online", color: Colors.green);
        }
      }

      if (status == InternetStatus.disconnected) {
        if (_articleList.isNotEmpty) {
          emit(OfflineStatus(articleList: _articleList));
        }
        if (!Platform.environment.containsKey('FLUTTER_TEST')) {
          consts.showToast("You're Offline", color: Colors.red);
        }
      }
      _prevStatus = status;
    });
  }

  Future<void> _mapLoadPopularNewsEventToState() async {
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
        );
      },
      (data) {
        _articleList.addAll(data.results ?? []);
        return LoadedPopularNewsState(articleList: data.results ?? []);
      },
    ));
  }
}
