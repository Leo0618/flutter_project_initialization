import 'package:FPL/data/data_repo.dart';
import 'package:FPL/data/model.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

/// ApplicationBloc
class ApplicationBloc implements BlocBase {
  BehaviorSubject<dynamic> _appEvent = BehaviorSubject<dynamic>();

  Sink<dynamic> get _appEventSink => _appEvent.sink;

  Stream<dynamic> get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  void sendAppEvent(dynamic data) {
    _appEventSink.add(data);
  }
}

/// MainBloc
class MainBloc extends BlocBase {
  // 测试信息
  BehaviorSubject<TestModel> _testSubject = BehaviorSubject<TestModel>();

  Sink<TestModel> get _testSink => _testSubject.sink;

  Stream<TestModel> get testStream => _testSubject.stream;

  void getTestData() async {
    DataRepo.getTestData().then((TestModel model) {
      if (!_testSubject.isClosed) _testSink.add(model);
    });
  }

  // dispose
  @override
  void dispose() {
    _testSubject.close();
  }
}
