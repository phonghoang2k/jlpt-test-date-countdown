import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildCategoryItem(String title, {String source, String link, String imageLink}) {
  return FlatButton(
    padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
    onPressed: () async => (await canLaunch(link)) ? launch(link) : Fluttertoast.showToast(msg: "Có lỗi xảy ra\nkhông thể mở được tài liệu"),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage("$imageLink"),
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$title", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              Text("$source", style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        )
      ],
    ),
  );
}
