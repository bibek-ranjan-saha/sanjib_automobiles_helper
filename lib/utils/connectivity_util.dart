import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  List<ConnectivityResult> activeStates = [
    ConnectivityResult.bluetooth,
    ConnectivityResult.wifi,
    ConnectivityResult.ethernet,
    ConnectivityResult.mobile,
    ConnectivityResult.vpn,
  ];

  static Future<bool> isConnected() async {
    bool isConnected = true;
    final connectionState = await Connectivity().checkConnectivity();
    if (connectionState == ConnectivityResult.none) {
      isConnected = false;
    }
    return isConnected;
  }
}
