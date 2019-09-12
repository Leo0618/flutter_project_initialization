import 'dart:convert';
import 'dart:io';

import 'package:FPL/comm/const.dart';
import 'package:FPL/comm/info.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flog/flog.dart';

/// function: DioManager
/// <p>Created by Leo on 2019/5/10.</p>

/// 日志打印详细度定义
enum LogLevel {
  /// 只打印输入输出请求
  IN_OUT,

  /// 打印全部日志信息
  IN_OUT_DETAIL
}

class DioManager {
  static const _TAG = 'DioManager';
  static final DioManager _singleton = DioManager._init();
  static Dio _dio;
  bool _debugLogLocal = false;

  static DioManager me() {
    return _singleton;
  }

  factory DioManager() {
    return _singleton;
  }

  DioManager._init() {
    _dio = new Dio(_defaultOption());
    _dio.interceptors.add(new InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.queryParameters.addAll(_commParameters);
    }));
    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: '${Info.directoryApp.path}/cookies')));
  }

  /// 重置配置信息
  void resetConfig(BaseOptions option) {
    if (option != null) {
      _dio.options = option;
    }
  }

  /// 设置日志打印
  void enableLog(LogLevel ll) {
    if (ll == LogLevel.IN_OUT) {
      _debugLogLocal = true;
    } else if (ll == LogLevel.IN_OUT_DETAIL) {
      _debugLogLocal = true;
      _dio.interceptors.add(LogInterceptor());
    } else {}
  }

  /// 默认基本配置
  BaseOptions _defaultOption() {
    BaseOptions option = new BaseOptions();
    option.baseUrl = Const.URL_BASE;
    option.contentType = ContentType.parse("application/x-www-form-urlencoded");
    option.connectTimeout = 1000 * 10;
    option.receiveTimeout = 1000 * 20;
    option.sendTimeout = 1000 * 10;
    return option;
  }

  /// 公共参数
  static Map<String, dynamic> _commParameters = {
    'system': Platform.operatingSystem,
    'device': Platform.isAndroid ? Info.androidDeviceInfo.model : Info.iosDeviceInfo.model,
    'deviceVersion': Platform.isAndroid ? Info.androidDeviceInfo.version.release : Info.iosDeviceInfo.systemVersion,
    'appVersion': Info.appVersion,
    'timestamp': new DateTime.now().millisecondsSinceEpoch.toString(),
  };

  /// post参数Map，已添加公共参数
  static Map<String, dynamic> postCommParams() {
    return Map.of(_commParameters);
  }

  /// GET
  Future<BaseResp<T>> get<T>(String path, {Map<String, dynamic> queryParameters, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.get(path, queryParameters: queryParameters, options: _checkOptions('GET', options), cancelToken: cancelToken);
    return _parseResponseData<T>(response);
  }

  /// POST
  Future<BaseResp<T>> post<T>(String path, {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.post(path, data: data, options: _checkOptions('POST', options), cancelToken: cancelToken);
    return _parseResponseData<T>(response);
  }

  /// other request
  Future<BaseResp<T>> request<T>(String method, String path, {Map<String, dynamic> datas, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(path, data: datas, options: _checkOptions(method, options), cancelToken: cancelToken);
    return _parseResponseData<T>(response);
  }

  //解析响应结果
  Future<BaseResp<T>> _parseResponseData<T>(Response response) {
    if (_debugLogLocal) {
      Flog.d("req==> " + response.request.uri.toString() + ", " + response.request.queryParameters.toString() + ", " + response.request.headers.toString(), tag: _TAG);
      Flog.d("rep==> " + response.toString(), tag: _TAG);
    }
    bool _success;
    int _code = 0;
    String _message = '';
    T _data;
    try {
      if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
        Map<String, dynamic> datas;
        if (response.data is Map) {
          datas = response.data;
        } else {
          datas = jsonDecode(response.data);
        }
        _success = datas[BaseRespField.SUCCESS];
        if (_success) {
          _data = datas[BaseRespField.PAYLOAD];
        } else {
          Map<String, dynamic> error = datas[BaseRespField.ERROR];
          _code = error[BaseRespField.CODE];
          _message = error[BaseRespField.MESSAGE];
        }
      }
    } catch (e) {
      _success = false;
      _code = -1;
      _message = e.toString();
    }
    return new Future.value(new BaseResp(_success, new BaseRespError(_code, _message), _data));
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options(method: method, contentType: ContentType.parse("application/x-www-form-urlencoded"));
    }
    return options;
  }
}

/// 响应结果基类字段
class BaseRespField {
  static const String SUCCESS = "success";
  static const String ERROR = "error";
  static const String CODE = "code";
  static const String MESSAGE = "message";
  static const String PAYLOAD = "payload";
}

/// 基类响应
class BaseResp<T> {
  bool success;
  BaseRespError error;
  T data;

  BaseResp(this.success, this.error, this.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("success:$success");
    sb.write(",error:$error");
    if (data != null) sb.write(",data:$data");
    sb.write('}');
    return sb.toString();
  }
}

/// 基类响应错误信息
class BaseRespError {
  int code;
  String message;

  BaseRespError(this.code, this.message);

  @override
  String toString() {
    return '{code: $code, message: $message}';
  }
}
