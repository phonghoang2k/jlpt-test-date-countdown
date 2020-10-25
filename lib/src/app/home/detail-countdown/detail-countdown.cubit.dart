import 'package:jlpt_testdate_countdown/src/models/date/date.dart';


class DetailCountdownData {
  int daysLeft;
  int hoursLeft;
  int minutesLeft;
  int secondsLeft;

  DetailCountdownData.fromDateCount(DateCount dateCount) {
    daysLeft = dateCount.timeLeft.inDays;
    hoursLeft = dateCount.timeLeft.inHours - (daysLeft * 24);
    minutesLeft = dateCount.timeLeft.inMinutes - (daysLeft * 24 * 60) - (hoursLeft * 60);
    secondsLeft = dateCount.timeLeft.inSeconds - (daysLeft * 24 * 60 * 60) - (hoursLeft * 60 * 60) - (minutesLeft * 60);
  }
}
