import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/detailed-learning/detailed-learning.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/type.dart';

class LearningMaterialModule extends ChildModule {
  static Inject get to => Inject<LearningMaterialModule>.of();

  static String detailLearning = "/detailLearning";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => LearningMaterial()),
        ModularRouter(detailLearning, child: (context, args) => DetailLearningData(args.data as Params)),
      ];
}
