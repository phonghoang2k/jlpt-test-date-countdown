import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future<bool> createMaterial(Map<String, dynamic> params) async {
    final response = await LearningMaterialService.createMaterial(params);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.data == "Imported!") ? true : throw NetworkException;
  }

  Future<bool> editMaterial(String id, Map<String, dynamic> params) async {
    final response = await LearningMaterialService.editMaterial(id, params);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.data == "updated") ? true : throw NetworkException;
  }

  Future<bool> deleteMaterial(String id) async {
    final response = await LearningMaterialService.deleteMaterial(id);
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return (response.data == "Deleted!") ? true : throw NetworkException;
  }
}
