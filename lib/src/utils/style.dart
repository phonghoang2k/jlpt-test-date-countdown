import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color mainTextColor = Color(0xFF121917);
  static const Color subTextColor = Color(0xff959595);
  static const Color fontColor = Color(0xFF607173);
  static const Color iconColor = Color(0xFFB2B2B2);

//  static const Color activeColor = Colors.black;
  static const Color borderColor = Color(0xFFEFEFEF);
  static const Color appColor = Colors.blue;
}

class AppText {
  static const middleSize = 16.0;

  static const middleText = TextStyle(
    color: AppColor.mainTextColor,
    fontSize: middleSize,
  );

  static const middleSubText = TextStyle(
    color: AppColor.subTextColor,
    fontSize: middleSize,
  );
}
