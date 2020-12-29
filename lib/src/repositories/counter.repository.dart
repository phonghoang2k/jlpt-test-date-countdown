import 'package:jlpt_testdate_countdown/src/models/date/date.dart';
import 'package:jlpt_testdate_countdown/src/models/target_date/target_date.dart';
import 'package:jlpt_testdate_countdown/src/services/date.service.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

class FakeDateRepository {
  DateCount fetchTime(DateTime testDate) {
    final Duration timeLeft = testDate.difference(DateTime.now());
    return DateCount(timeLeft: timeLeft);
  }

  Future<List<TargetDate>> fetchAllLearningMaterial() async {
    final response = await DateService.getAllTargetDates();
    return response.statusCode == 200
        ? (response.data as List).map((e) => TargetDate.fromJson(e as Map<String, dynamic>)).toList()
        : throw NetworkException;
  }
}
