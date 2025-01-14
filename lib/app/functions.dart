import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../domain/model/model.dart';

Future<DeviceInfo> getDeviceInfo() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      // return android
      var build = await deviceInfo.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.id;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      // return ios
      var build = await deviceInfo.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor ?? "Unknown";
      version = build.systemVersion;
    } else {
      // return web
      name = "Web";
      identifier = "Web";
      version = "Web";
    }
  } on PlatformException {
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}
