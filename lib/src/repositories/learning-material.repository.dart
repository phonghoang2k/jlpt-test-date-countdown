import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart';
import 'package:jlpt_testdate_countdown/src/services/learning-material.service.dart';
import 'package:jlpt_testdate_countdown/src/utils/exception.dart';

class LearningMaterialRepository {
  Future<List<Data>> fetchAllLearningMaterial() async {
    final response = await LearningMaterialService.getAllLearningMaterial();
    return response.statusCode == 200 ? (response.data as List).map((e) => Data.fromJson(e as Map<String, dynamic>)).toList() : throw NetworkException;
  }

  Future<List<Data>> fetchLearningBaseOnParams(Map<String, dynamic> params) async {
    final response = await LearningMaterialService.getLearningMaterial(params);
    return response.statusCode == 200 ? (response.data as List).map((e) => Data.fromJson(e as Map<String, dynamic>)).toList() : throw NetworkException;
  }
}
