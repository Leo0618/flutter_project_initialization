import 'package:FPL/util/utils.dart';

/// function: data_repository
/// <p>Created by Leo on 2019/5/10.</p>
///

import 'dio_manager.dart';
import 'model.dart';

class Api {
  static const test = 'test.json';
}

class DataRepo {
  /// 获取测试数据
  static Future<TestModel> getTestData() async {
    BaseResp<dynamic> resp = await DioManager.me().get<dynamic>(Api.test);
    if (resp.data != null) {
      return TestModel.fromJson(resp.data);
    }
    if (resp.error != null && resp.error.message != null) {
      Utils.toast(resp.error.message);
    }
    return null;
  }
}
