import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> getConnectivityStatus() async {
    final isConnected = await Connectivity().checkConnectivity().then((result) {
      return switch (result) {
        ConnectivityResult.wifi || ConnectivityResult.mobile => true,
        _ => false,
      };
    });
    return isConnected;
  }
}
