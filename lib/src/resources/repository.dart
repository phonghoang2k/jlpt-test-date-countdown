import 'package:jlpt_testdate_countdown/src/models/date.dart';

abstract class DateRepository {
  Date fetchTime(DateTime testDate);
}

class FakeDateRepository implements DateRepository {
  @override
  Date fetchTime(DateTime testDate) {
    final Duration timeLeft = testDate.difference(DateTime.now());
    return Date(timeLeft: timeLeft);
  }
}
