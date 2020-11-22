import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/component/item.component.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class DetailLearningData extends StatefulWidget {
  final String title;

  const DetailLearningData(this.title) : super();

  @override
  _DetailLearningDataState createState() => _DetailLearningDataState();
}

class _DetailLearningDataState extends State<DetailLearningData> {
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
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                Text("${widget.title}",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))
              ],
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
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  // Todo: Based on Api
                  ...List.generate(
                      12, (index) => buildCategoryItem("${widget.title} ${++index}", link: "https://www.google.com"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
