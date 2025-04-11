import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoManager {
  static final DeviceInfoManager _instance = DeviceInfoManager._internal();
  factory DeviceInfoManager() => _instance;

  DeviceInfoManager._internal();

  String? deviceId;
  bool isDeviceManagerChecked = false;

  bool adminMode = true; // true: admin, false: user

  Future<void> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // ANDROID_ID (변경될 가능성이 적음)
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor; // iOS 기기 식별 ID
    }
  }

  bool isAdmin() {
    return deviceId == "2A671044-304F-40A6-BC2D-7715BD585F46";
  }
}
