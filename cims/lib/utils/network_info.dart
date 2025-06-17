import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  static final NetworkInfo _instance = NetworkInfo._internal();
  factory NetworkInfo() => _instance;

  NetworkInfo._internal();

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) return false;

    return await InternetConnectionChecker().hasConnection;
  }

  Stream<bool> get onStatusChange => Connectivity()
      .onConnectivityChanged
      .asyncMap((_) => isConnected())
      .asBroadcastStream();
}
