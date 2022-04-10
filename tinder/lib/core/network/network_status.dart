import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
}

class NetworkStatusImpl implements NetworkStatus {
  InternetConnectionChecker connectionChecker;

  Connectivity connectivity;
  bool _isConnectToNetwork = true;
  NetworkStatusImpl(this.connectionChecker, this.connectivity) {
    connectionChecker.onStatusChange.listen((event) {
      _isConnectToNetwork = (event == InternetConnectionStatus.connected);
    });
    connectivity.onConnectivityChanged.listen((event) {
      _isConnectToNetwork = (event != ConnectivityResult.none);
    });
  }

  @override
  Future<bool> get isConnected async {
    return _isConnectToNetwork;
  }
}
