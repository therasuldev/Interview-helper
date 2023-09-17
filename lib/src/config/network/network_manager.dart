import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// There are only two connection status, [online] and [offline].
/// Used for controlling ping results.
enum ConnectivityStatus { online, offline }

extension ConnectivityStatusExt on ConnectivityStatus {
  bool get isConnected => this == ConnectivityStatus.online;
}

/// Wrapper service of [Connectivity].
/// Makes it easy to listen connectivity and update the state.
class ConnectivityService {
  ConnectivityService({Connectivity? connectivity}) {
    if (connectivity != null) _connectivity = connectivity;
  }

  Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  // Main stream controller, that we use to listen user changes.
  final StreamController<ConnectivityStatus> controller =
      StreamController<ConnectivityStatus>.broadcast();

  // A shortcut getter for controller's stream.
  Stream<ConnectivityStatus> get stream => controller.stream;

  // isConnected is a getter method to check
  // if device is connected or not. as [BOOLEAN].
  static Future<bool> get isConnected async {
    final status = await ConnectivityService().checkConnectivity(
      notifyStream: false,
    );

    return status == ConnectivityStatus.online;
  }

  // Basic connectivity checking.
  Future<ConnectivityStatus> checkConnectivity({
    bool notifyStream = true,
  }) async {
    final res = await _connectivity.checkConnectivity();
    final status = statusFromResult(res);

    if (notifyStream) controller.add(status);
    return status;
  }

  // Initilazes [_connectivitySubscription].
  // Which actually means, it starts listening connectivity.
  Future<void> listenConnectivity({
    Function(ConnectivityStatus)? onChanged,
  }) async {
    // We check connection directly at first time,
    // Because, [onConnectivityChanged] doesn't emits first states.
    // So, if you open application without connection, stream won't first "none" value.
    // It will be [null], until connectivity state updates.
    final firstCheckRes = await _connectivity.checkConnectivity();
    await Future.delayed(const Duration(seconds: 1));
    controller.add(statusFromResult(firstCheckRes));

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        final ConnectivityStatus status = statusFromResult(event);

        controller.add(status);
        onChanged?.call(status);
      },
    );
  }

  // Returns [ConnectivityStatus] from [Connectivity] library's [ConnectivityResult].
  ConnectivityStatus statusFromResult(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      return ConnectivityStatus.offline;
    }

    return ConnectivityStatus.online;
  }

  void cancelSubscription() {
    _connectivitySubscription?.cancel();
    controller.close();
  }
}
