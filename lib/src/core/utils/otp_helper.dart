import 'package:education_app/src/core/utils/local_storage.dart';

class OtpHelper {
  OtpHelper(this._storage);

  final LocalStorage _storage;

  incrementOtpReqCount() async {
    int count = _storage.getOtpReqTimes;
    if (count == 6) {
      count = 0;
    }
    count++;
    await _storage.setOtpReqTimes(count);
    await _setNextAttemptTime(count);
  }

  //otp delay requests based on number of requests
  Future<void> _setNextAttemptTime(int times) async {
    final now = DateTime.now();
    DateTime td;
    td = now.add(const Duration(seconds: 20)); // 1 min
    await _storage.setNextOtpAttempt(td.toString());
    return;
    switch (times) {
      case 1:
        td = now.add(const Duration(minutes: 1)); // 1 min
        await _storage.setNextOtpAttempt(td.toString());
        break;
      case 2:
        td = now.add(const Duration(minutes: 3)); // 3 min
        await _storage.setNextOtpAttempt(td.toString());
        break;
      case 3:
        td = now.add(const Duration(minutes: 15)); //10 min
        await _storage.setNextOtpAttempt(td.toString());
        break;
      case 4:
        td = now.add(const Duration(hours: 1)); //1 hours
        await _storage.setNextOtpAttempt(td.toString());
        break;
      case 5:
        td = now.add(const Duration(hours: 24)); //24 hours
        await _storage.setNextOtpAttempt(td.toString());
        break;
      case 6:
        td = now.add(const Duration(hours: 96)); //96 hours
        await _storage.setNextOtpAttempt(td.toString());
        break;
      default:
        td = now.add(const Duration(minutes: 3)); //3 minutes
        await _storage.setNextOtpAttempt(td.toString());
    }
  }

  bool nextAttemptAvailable() {
    final now = DateTime.now();
    int count = _storage.getOtpReqTimes;
    String? nextAttemptTime = _storage.getNextOtpAttempt;
    bool isNextAttempt =
        count == 0 ? true : DateTime.parse(nextAttemptTime!).isBefore(now);
    if (count == 0) {
      return true;
    } else if (count <= 6 && isNextAttempt) {
      return true;
    } else {
      return false;
    }
  }

  String? get getNextAttemptText {
    int times = getNextOtpAttemptInSeconds();

    final reminderHours = times ~/ 3600;
    int reminderMinutes = times % 3600 ~/ 60;
    final reminderSeconds = times % 60;

    if (reminderHours > 0 && reminderMinutes > 0) {
      return 'يرجى اعادة المحاولة بعد $reminderHours ساعة و $reminderMinutes دقيقة';
    }

    if (reminderHours == 1 && reminderMinutes < 0) {
      reminderMinutes = (reminderHours * 60) - reminderMinutes;
      return 'يرجى اعادة المحاولة بعد $reminderMinutes دقيقة';
    }

    if (reminderHours > 0) {
      return 'يرجى اعادة المحاولة بعد $reminderHours ساعة';
    }

    if (reminderMinutes > 0) {
      return 'يرجى اعادة المحاولة بعد $reminderMinutes دقيقة';
    }

    if (reminderSeconds > 0) {
      return 'يرجى اعادة المحاولة بعد $reminderSeconds ثانية';
    }
    return null;
  }

  int getNextOtpAttemptInSeconds() {
    final now = DateTime.now();
    DateTime nextOtpAttempt = now;
    final nextAttempt = _storage.getNextOtpAttempt;
    if (nextAttempt != null) {
      nextOtpAttempt = DateTime.parse(nextAttempt);
    }
    final Duration nextOtpAttemptTime =
        nextOtpAttempt.difference(DateTime.now());
    final times =
        nextOtpAttemptTime <= Duration.zero ? 0 : nextOtpAttemptTime.inSeconds;
    return times;
  }

  Future<void> clearNextAttempt() async {
    await _storage.setOtpReqTimes(0);
  }
}
