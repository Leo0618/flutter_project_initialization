import 'dart:io';

/// function: info
/// <p>Created by Leo on 2019/5/10.</p>

import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'package:path_provider/path_provider.dart';

class Info {
  /// The app name. `CFBundleDisplayName` on iOS, `application/label` on Android.
  static String appName;

  /// The package name. `bundleIdentifier` on iOS, `getPackageName` on Android.
  static String packageName;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName` on Android.
  static String appVersion;

  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  static String buildNumber;

  /// Information derived from `android.os.Build`.
  static AndroidDeviceInfo androidDeviceInfo;

  /// Information derived from `UIDevice`.
  static IosDeviceInfo iosDeviceInfo;

  /// getTemporaryDirectory
  static Directory directoryTemp;

  /// getApplicationDocumentsDirectory
  static Directory directoryApp;

  static Future<bool> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    appVersion = packageInfo.version;
    buildNumber = packageInfo.buildNumber;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      androidDeviceInfo = await deviceInfo.androidInfo;
    }
    if (Platform.isIOS) {
      iosDeviceInfo = await deviceInfo.iosInfo;
    }

    directoryTemp = await getTemporaryDirectory();
    directoryApp = await getApplicationDocumentsDirectory();
    return true;
  }
}
