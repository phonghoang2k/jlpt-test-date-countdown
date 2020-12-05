import 'package:jlpt_testdate_countdown/src/env/application.dart';

class LearningMaterialService {
  static Future<dynamic> getAllLearningMaterial() {
    return Application.api.get("/documents");
  }

  static Future<dynamic> getLearningMaterial(Map<String, dynamic> params) {
    return Application.api.get("/documents", params);
  }

  static Future<dynamic> createMaterial(Map<String, dynamic> params) {
    return Application.api.post("/documents", params);
  }

  static Future<dynamic> editMaterial(Map<String, dynamic> query, Map<String, dynamic> params) {
    return Application.api.put("/documents", query, params);
  }

  static Future<dynamic> deleteMaterial(Map<String, dynamic> params) {
    return Application.api.delete("/students", params);
  }
}
