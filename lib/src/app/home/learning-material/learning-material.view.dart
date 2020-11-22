import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/component/item.component.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.module.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class LearningMaterial extends StatefulWidget {
  @override
  _LearningMaterialState createState() => _LearningMaterialState();
}

class _LearningMaterialState extends State<LearningMaterial> {
  LearningMaterialCubit _cubit = LearningMaterialCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: DataConfig.imageAssetsLink[Application.sharePreference.getInt("imageIndex") ?? 0],
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.0))),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 4,
              top: SizeConfig.safeBlockVertical * 12,
              right: SizeConfig.safeBlockHorizontal * 4,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Tài liệu ôn thi",
                          style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  buildSlidableCategory("Tài liệu luyện thi theo môn học", _cubit.subjects),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  buildSlidableCategory("Đề thi thử theo môn học", _cubit.subjects),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tài liệu mới cập nhật",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical),
                  ...List.generate(
                      5, (index) => buildCategoryItem("Tài liệu môn toán", link: "https://www.google.com")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSlidableCategory(String title, List data) => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("$title", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  data.length,
                  (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal),
                        width: SizeConfig.safeBlockHorizontal * 25,
                        height: SizeConfig.safeBlockVertical * 8,
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(20), color: _cubit.colorList[index]),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: () => Modular.link
                              .pushNamed(LearningMaterialModule.detailLearning, arguments: data.elementAt(index)),
                          child: Center(
                            child: Text(
                              "${data.elementAt(index)}",
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical),
          Row(
            children: [
              SizedBox(width: SizeConfig.safeBlockHorizontal),
              FlatButton(
                // Todo: Navigate and call api
                onPressed: () => Modular.link.pushNamed(LearningMaterialModule.detailLearning, arguments: title),
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward_sharp, color: Colors.white, size: 35),
                    SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
                    Text("Xem tất cả", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          )
        ],
      );
}
