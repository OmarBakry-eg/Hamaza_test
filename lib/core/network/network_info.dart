import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<InternetStatus> get isStreamConnected;
  Future<InternetStatus> get internetStatus;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnection dataConnectionChecker;

  const NetworkInfoImpl(this.dataConnectionChecker);

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasInternetAccess;

  @override
  Stream<InternetStatus> get isStreamConnected =>
      dataConnectionChecker.onStatusChange;

  @override
  Future<InternetStatus> get internetStatus => dataConnectionChecker.internetStatus;
}
