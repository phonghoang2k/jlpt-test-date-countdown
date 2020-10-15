import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.view.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';

class HomeModule extends ChildModule {
  static Inject get to => Inject<HomeModule>.of();

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
        Bind((inject) => CounterCubit()),
        Bind((inject) => FakeDateRepository()),
      ];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => HomeWidget()),
      ];
}
