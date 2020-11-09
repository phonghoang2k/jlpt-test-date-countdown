import 'package:flutter_modular/flutter_modular.dart';
import 'package:jlpt_testdate_countdown/src/app/home/cubit/counter.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/detail-countdown/detail-countdown.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/note/note-page.view.dart';
import 'package:jlpt_testdate_countdown/src/app/home/recorder/recorder_message.dart';
import 'package:jlpt_testdate_countdown/src/app/home/study-music/music.view.dart';
import 'package:jlpt_testdate_countdown/src/repositories/counter.repository.dart';

class HomeModule extends ChildModule {
  static Inject get to => Inject<HomeModule>.of();

  static String detailCountdown = "/detailCountdown";
  static String music = "/music";
  static String note = "/note";
  static String recorder = "/recorder";

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
        ModularRouter(music, child: (context, args) => MusicApp()),
        ModularRouter(detailCountdown, child: (context, args) => DetailCountdown()),
        ModularRouter(recorder, child: (context, args) => Recorder()),
        ModularRouter(note, child: (context, args) => NotePage()),
      ];
}
