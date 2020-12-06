import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/add-learning-material/add-learning-material.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/add-learning-material/type.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/models/learning_data/learning_data.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';

class AddLearningMaterial extends StatefulWidget {
  final Data data;

  const AddLearningMaterial({this.data}) : super();

  @override
  _AddLearningMaterialState createState() => _AddLearningMaterialState();
}

class _AddLearningMaterialState extends State<AddLearningMaterial> {
  AddLearningCubit _cubit = AddLearningCubit(LearningMaterialRepository());

  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                image: DataConfig.imageAssetsLink[Application.sharePreference.getInt("imageIndex") ?? 0],
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.0))),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                Text(widget.data == null ? "Thêm Học Liệu" : "Chỉnh sửa Học Liệu",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 6, vertical: SizeConfig.safeBlockVertical * 3),
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                children: [
                  Spacer(flex: 3),
                  FormBuilderTextField(
                    attribute: "name",
                    initialValue: widget.data?.name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Tên học liệu",
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: "link",
                    initialValue: widget.data?.link,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      labelText: "Đường dẫn học liệu",
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: "linkavt",
                    initialValue: widget.data?.linkavt,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    validators: [FormBuilderValidators.required()],

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                      labelText: "Đường dẫn hình ảnh đại diện",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  FormBuilderTextField(
                    attribute: "source",
                    initialValue: widget.data?.source,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Nguồn gốc",
                      errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown(
                          attribute: "subject",
                          initialValue: widget.data != null ? _cubit.subjectConvert.firstWhere((element) => element.output == widget.data.subject) : null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                            labelText: "Môn học",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          dropdownColor: Colors.transparent,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          validators: [FormBuilderValidators.required()],
                          items: _cubit.subjectConvert.map((SubjectTypeConvert item) => DropdownMenuItem(value: item, child: Text("${item.input}"))).toList(),
                        ),
                      ),
                      SizedBox(width: SizeConfig.safeBlockHorizontal * 20),
                      Expanded(
                        child: FormBuilderDropdown(
                          attribute: "type",
                          initialValue: widget.data != null ? _cubit.typeConvert.firstWhere((element) => element.output == widget.data.type) : null,
                          dropdownColor: Colors.transparent,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
                            labelText: "Thể loại",
                            labelStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          validators: [FormBuilderValidators.required()],
                          items: _cubit.typeConvert.map((SubjectTypeConvert item) => DropdownMenuItem(value: item, child: Text("${item.input}"))).toList(),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 6),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton(
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        widget.data == null
                            ? _cubit.createNewMaterial(_fbKey.currentState.value).whenComplete(() => Navigator.pop(context))
                            : _cubit.editMaterial(_fbKey.currentState.value, id: widget.data.id).whenComplete(() => Navigator.pop(context));
                      } else {
                        Fluttertoast.showToast(
                          msg: "Chưa điền đầy đủ các trường",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                  FlatButton(onPressed: () => Navigator.pop(context), child: Text("Close", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
