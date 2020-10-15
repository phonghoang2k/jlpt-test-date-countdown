import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/app.module.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  Future<Timer> startTime() async => Timer(Duration(seconds: 3), navigationPage);

  @override
  void initState() {
    super.initState();
    startTime();
  }

  void navigationPage() => Modular.to.pushReplacementNamed(AppModule.home);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold();
  }
}
