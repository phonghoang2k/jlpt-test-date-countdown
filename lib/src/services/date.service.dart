import 'package:jlpt_testdate_countdown/src/env/application.dart';

class DateService {
  static Future<dynamic> getAllTargetDates() {
    return Application.api.get("/dates");
  }
}
