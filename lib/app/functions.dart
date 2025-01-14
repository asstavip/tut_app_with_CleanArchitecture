import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceInfo() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfo deviceInfo = DeviceInfoPlugin() as DeviceInfo;

  try {
    if (Platform.isAndroid) {
      // return android
    } else if (Platform.isIOS) {
      // return ios
    } else {
      // return web
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
