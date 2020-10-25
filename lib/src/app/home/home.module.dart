import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.view.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';
import 'package:jlpt_testdate_countdown/src/views/screens/details_countdown.dart';

class HomeModule extends ChildModule {
  static Inject get to => Inject<HomeModule>.of();

  static String detailCountdown = "/detailCountdown";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((inject) => FakeDateRepository()),
        Bind((inject) => CounterCubit()),
      ];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => HomeWidget()),
        ModularRouter(detailCountdown, child: (context, args) => DetailCountDown()),
      ];
}
