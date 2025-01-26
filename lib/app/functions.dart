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

bool isEmailValid(String email) {
  // Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
  // TODO : remove comments and implement password validation
  // final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  // return regex.hasMatch(password);
  return RegExp(
          r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
      .hasMatch(email);
}
