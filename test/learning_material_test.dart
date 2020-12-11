import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jlpt_testdate_countdown/src/app/home/home.view.dart';

void main() {
  testWidgets("show speed dial test", (WidgetTester tester) async {
    await tester.pumpWidget(HomeWidget());

    expect(find.text('CÒN'), findsOneWidget);
    expect(find.text("Nếu yêu nhau"), findsNothing);

    await tester.tap(find.byElementType(SpeedDial));
    await tester.pump();
  });
}
