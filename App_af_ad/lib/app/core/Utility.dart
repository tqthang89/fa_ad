import 'dart:io';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class Utility {
  static const chanel = MethodChannel("ConnectSwift");

  static Future<bool> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<bool> iosGPSEnable() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled == null || !isLocationServiceEnabled) {
      return false;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  static void nextFocus(BuildContext context) {
    do {
      FocusScope.of(context).nextFocus();
    } while (
        FocusScope.of(context).focusedChild.context.widget is! EditableText);
  }

  static void unFocus(BuildContext context) {
    do {
      FocusScope.of(context).unfocus();
    } while (
        FocusScope.of(context).focusedChild.context.widget is! EditableText);
  }

  static String getPlatform() {
    String os = Platform.operatingSystem;
    return os;
  }

  static double deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  static double rad2deg(double rad) {
    return (rad * 180 / pi);
  }

  static double distance(
      double lat1, double lon1, double lat2, double lon2, String unit) {
    double theta = lon1 - lon2;
    double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
        cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
    dist = acos(dist);
    dist = rad2deg(dist);
    dist = dist * 60 * 1.1515;
    if (unit == "K") {
      dist = dist * 1.609344;
    } else if (unit == "N") {
      dist = dist * 0.8684;
    }
    return (dist);
  }

  static Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int version = int.tryParse(packageInfo.buildNumber);
    return version.toString();
  }
  static Future<String> getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  static Future<String> getDocumentPath() async {
    Directory documents = await getApplicationDocumentsDirectory();
    return documents.path;
  }

  static String genaralCode(int length, String addChar) {
    const String _chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    Random _rnd = Random();
    return addChar +
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static Future<String> getDirectoryPath() async {
    try {
      return await chanel.invokeMethod("getDirectoryPath");
    } catch (ex) {
      return null;
    }
  }

  static double getWidthScreen(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeightScreen(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
