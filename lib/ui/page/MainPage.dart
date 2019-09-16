import 'package:FPL/bloc/index_bloc.dart';
import 'package:FPL/comm/c.dart';
import 'package:FPL/data/model.dart';
import 'package:FPL/generated/i18n.dart';
import 'package:FPL/ui/widget/app_dialog.dart';
import 'package:flutter/material.dart';

/// function: MainPage
/// <p>Created by Leo on 2019/9/12.</p>
class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _dataLoaded = false;

  _initData(MainBloc _bloc, BuildContext context) {
    if (_dataLoaded) return;
    _dataLoaded = true;
    _bloc.getTestData();
  }

  @override
  Widget build(BuildContext context) {
    MainBloc _bloc = BlocProvider.of<MainBloc>(context);
    _initData(_bloc, context);
    return new Scaffold(
      appBar: AppBar(title: Text(S.current.app_name)),
      body: Container(
        color: C.bg_window,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                child: Text("Refresh", style: TextStyle(color: Colors.white, fontSize: 20)),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                margin: EdgeInsets.all(10),
                color: Colors.lightBlue,
              ),
              onTap: () {
                showLoadingDialog(context);
                _bloc.getTestData();
              },
            ),
            Expanded(
              child: Center(
                child: StreamBuilder(
                    stream: _bloc.testStream,
                    builder: (BuildContext context, AsyncSnapshot<TestModel> snapshot) {
                      if (_isLoading) {
                        Navigator.pop(context);
                        _isLoading = false;
                      }
                      try {
                        print("===>${snapshot.data.msg}");
                        return new Text(snapshot.data.msg, style: TextStyle(color: Colors.redAccent, fontSize: 20));
                      } catch (e) {}
                      return CircularProgressIndicator();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isLoading = false;

  //提示 LoadingDialog
  void showLoadingDialog(BuildContext context) {
    _isLoading = true;
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new LoadingDialog(
            text: '加载中...',
            backgroundColor: Colors.white,
            textColor: Colors.teal,
          );
        });
  }
}
