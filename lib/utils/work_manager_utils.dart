import 'package:flutter_interview_questions/utils/notifications_utils.dart';
import 'package:workmanager/workmanager.dart';

class WorkmanagerUtils {
  WorkmanagerUtils._();
  static void callbackDispatcher() {
    Workmanager().executeTask((_, __) async {
      await NotificationUtils.initialize();
      return Future.value(true);
    });
  }
}
