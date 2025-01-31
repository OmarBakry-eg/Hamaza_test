class Result<T> {
  Result._();

  factory Result.loading(T msg) = LoadingState<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(T msg, num? statusCode) = ErrorState<T>;

  factory Result.networkError(T msg) = NetworkErrorState<T>;
}

class LoadingState<T> extends Result<T> {
  LoadingState(this.msg) : super._();
  final T msg;
}

class ErrorState<T> extends Result<T> {
  ErrorState(this.msg, this.statusCode) : super._();
  final T msg;
  final num? statusCode;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  final T value;
}

class NetworkErrorState<T> extends Result<T> {
  NetworkErrorState(this.msg) : super._();
  final T msg;
}
