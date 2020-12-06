import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/learning-material.module.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart' as learning_data;
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildCategoryItem(learning_data.Data data, BuildContext context, {VoidCallback onEventEmitted}) {
  return FlatButton(
    onLongPress: () => _showAlert(context, data: data, onEventDone: onEventEmitted),
    padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical),
    onPressed: () async => (await canLaunch(data.link))
        ? launch(data.link)
        : Fluttertoast.showToast(
            msg: "Có lỗi xảy ra\nkhông thể mở được tài liệu",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage("${data.linkavt}"),
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal * 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.name}", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
              Text("${data.source}", style: TextStyle(fontSize: 18, color: Colors.white)),
            ],
          ),
        )
      ],
    ),
  );
}

void _showAlert(BuildContext context, {learning_data.Data data, VoidCallback onEventDone}) {
  showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
            message: Text(
              "Tuỳ chọn",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.blue),
                ),
                isDestructiveAction: true,
                onPressed: () => Modular.link.pushNamed(LearningMaterialModule.addLearning, arguments: data).whenComplete(() => Navigator.pop(context)),
              ),
              CupertinoActionSheetAction(
                child: Text(
                  "Xoá",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                isDestructiveAction: true,
                onPressed: () => Modular.get<LearningMaterialCubit>().deleteMaterial(data.id).whenComplete(() => Navigator.pop(context)),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text("Huỷ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              onPressed: () => Navigator.pop(context),
            ),
          )).then((value) => onEventDone());
}
