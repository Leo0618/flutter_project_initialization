import 'package:FPL/bloc/index_bloc.dart';
import 'package:flog/flog.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../r.dart';
import '../../comm/info.dart';
import 'MainPage.dart';

/// function: SplashPage
/// <p>Created by Leo on 2019/5/8.</p>
class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  //延迟秒数
  double _delayTime = 3;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    int star = DateTime.now().millisecondsSinceEpoch;
    Flog.config(true);
    bool deviceInitFinish = await Info.init();
    if (deviceInitFinish) {
      double costTime = (DateTime.now().millisecondsSinceEpoch - star) / 1000;
      costTime = (costTime < _delayTime) ? _delayTime - costTime : costTime;
      Observable.just(1).delay(new Duration(seconds: costTime.toInt())).listen((_) {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
              builder: (BuildContext ctx) => BlocProvider(child: new MainPage(), bloc: new MainBloc()),
            ));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      R.assetsImgBgSplash,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
