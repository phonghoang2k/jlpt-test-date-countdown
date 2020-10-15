import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:jlpt_testdate_countdown/src/app/intro/intro.view.dart';
import 'package:jlpt_testdate_countdown/src/utils/style.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    // Application.api = API();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', "US"), const Locale('vi', "VN")],
      title: 'JLPT Testdate Countdown',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
        primaryColor: AppColor.appColor,
        accentColor: Colors.redAccent,
        fontFamily: "Quicksand",
      ),
      home: I18n(
        child: Introduction(),
        initialLocale: Locale('vi', "VN"),
      ),
      navigatorKey: Modular.navigatorKey,
      // add Modular to manage the routing system
      onGenerateRoute: Modular.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
