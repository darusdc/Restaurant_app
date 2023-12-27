import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:resto_mana/utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledResto(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
