class ServerException implements Exception {
  final String message;
  final num statusCode;
  ServerException({this.message = 'Server Exception', this.statusCode = 500});
}

class EmptyCacheException implements Exception {
  final String message;
  const EmptyCacheException({this.message = 'Empty Cache Exception'});
}

class OfflineException implements Exception {
  final String message;
  const OfflineException({this.message = 'Offline Exception'});
}
