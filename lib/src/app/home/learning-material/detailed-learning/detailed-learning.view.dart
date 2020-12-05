import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/component/item.component.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/detailed-learning/detailed-learning.cubit.dart';
import 'package:jlpt_testdate_countdown/src/app/home/learning-material/type.dart';
import 'package:jlpt_testdate_countdown/src/env/application.dart';
import 'package:jlpt_testdate_countdown/src/repositories/learning-material.repository.dart';
import 'package:jlpt_testdate_countdown/src/resources/data.dart';
import 'package:jlpt_testdate_countdown/src/utils/sizeconfig.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailLearningData extends StatefulWidget {
  final Params params;

  const DetailLearningData(this.params) : super();

  @override
  _DetailLearningDataState createState() => _DetailLearningDataState();
}

class _DetailLearningDataState extends State<DetailLearningData> {
  DetailLearningCubit _cubit;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    _cubit = DetailLearningCubit(LearningMaterialRepository(), params: widget.params);
    super.initState();
  }

  void onRefresh() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _refreshController.refreshCompleted();
    });
  }

  void onLoading() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _cubit.pull();
      _refreshController.loadComplete();
    });
  }

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
                Text("${widget.params.title}", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Container(
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal * 3,
              top: SizeConfig.safeBlockVertical * 12,
              right: SizeConfig.safeBlockHorizontal * 3,
            ),
            child: Scrollbar(
              child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                header: WaterDropMaterialHeader(),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowWhenLoading,
                  completeDuration: Duration(milliseconds: 500),
                  canLoadingIcon: const Icon(Icons.autorenew, color: Colors.white),
                  textStyle: TextStyle(color: Colors.white),
                  loadingIcon: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: defaultTargetPlatform == TargetPlatform.iOS
                        ? Theme(
                            data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                            child: CupertinoActivityIndicator(),
                          )
                        : const CircularProgressIndicator(strokeWidth: 2.0, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                ),
                onRefresh: onRefresh,
                onLoading: onLoading,
                controller: _refreshController,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.safeBlockVertical * 2),
                      BlocBuilder<DetailLearningCubit, DetailedLearningState>(
                          cubit: _cubit,
                          buildWhen: (prev, now) => now is DetailedLearningDataLoaded,
                          builder: (context, state) => state is DetailedLearningDataLoaded
                              ? Column(
                                  children: List.generate(state.data.length, (index) => buildCategoryItem(state.data.elementAt(index), context)),
                                )
                              : CircularProgressIndicator())
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
