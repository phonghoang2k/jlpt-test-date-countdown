import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/add-learning-material/add-learning-material.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/detailed-learning/detailed-learning.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/type.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart' as learning_data;
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';

class LearningMaterialModule extends ChildModule {
  static Inject get to => Inject<LearningMaterialModule>.of();

  static String detailLearning = "/detailLearning";
  static String addLearning = "/addLearning";

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [Bind((e) => LearningMaterialCubit(LearningMaterialRepository()))];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (context, args) => LearningMaterial()),
        ModularRouter(detailLearning, child: (context, args) => DetailLearningData(args.data as Params)),
        ModularRouter(addLearning, child: (context, args) => AddLearningMaterial(data: args.data as learning_data.Data), transition: TransitionType.downToUp),
      ];
}
