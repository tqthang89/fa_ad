import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';

class Shared {
  static GetStorage _storage;

  static write({String key, dynamic value}) async {
    if (_storage == null) _storage = new GetStorage();
    await _storage.write(key, value);
  }

  static Future<T> read<T>({String key}) async {
    if (_storage == null) _storage = new GetStorage();
    return await _storage.read(key);
  }

  static Future<void> remove({String key}) async {
    if (_storage == null) _storage = new GetStorage();
    return await _storage.remove(key);
  }

  static Future<void> setUser(LoginInfo user) async {
    String json = jsonEncode(user);
    await write(key: 'UserLogin', value: json);
  }

  static Future<LoginInfo> getUser() async {
    String data = await read(key: 'UserLogin');
    if (data != null) {
      Map userMap = jsonDecode(data);
      if (userMap != null) {
        var user = LoginInfo.fromJson(userMap);
        return user;
      }
      return null;
    }
    return null;
  }

  static Future<void> setMaster(Object master) async {
    String json = jsonEncode(master);
    await write(key: 'Master', value: json);
  }

  static Future<List<MasterInfo>> getMaster() async {
    String data = await read(key: 'Master');
    if (data != null) {
      List<MasterInfo> masters =
          (jsonDecode(data) as List).map((i) => MasterInfo.fromJson(i)).toList();
      return masters;
    }
    return null;
  }
}
