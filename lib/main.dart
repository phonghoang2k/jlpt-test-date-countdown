import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/blocs/bloc.dart';
import 'package:jlpt_testdate_countdown/src/resources/repository.dart';
import 'package:jlpt_testdate_countdown/src/views/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Đếm ngược ngày thi JLPT',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) => DateBloc(FakeDateRepository()),
          child: MyHomePage(),
        ));
  }
}
