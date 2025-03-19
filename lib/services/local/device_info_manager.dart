import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoManager {
  static final DeviceInfoManager _instance = DeviceInfoManager._internal();
  factory DeviceInfoManager() => _instance;

  DeviceInfoManager._internal();

  String? deviceId;

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
    return deviceId == "FC2818C2-34C6-4962-92F1-256B74193C16";
  }
}
