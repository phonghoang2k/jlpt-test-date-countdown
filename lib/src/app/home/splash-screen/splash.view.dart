import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

import '../home.view.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 3000),
        () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeWidget())));
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
          height: SizeConfig.screenHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              image: DataConfig.imageAssetsLink[Application.sharePreference.getInt("imageIndex") ?? 0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: SizeConfig.blockSizeHorizontal * 50,
          child: Image.asset('assets/app_icon.PNG', fit: BoxFit.fitWidth),
          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 5)),
        )
      ]),
    );
  }
}
