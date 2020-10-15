// app_module.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/app.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.module.dart';
import 'package:jlpt_testdate_countdown/src/app/intro/intro.view.dart';

class AppModule extends MainModule {
  static Inject get to => Inject<AppModule>.of();
  static String home = "/home";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter(home, module: HomeModule(), transition: TransitionType.rightToLeftWithFade),
        ModularRouter('/', child: (context, args) => Introduction(), transition: TransitionType.rightToLeftWithFade),
      ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => AppWidget();
}
