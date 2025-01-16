import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/models/AttendantInfo.dart';

class PhotoContext {
  static Future<List<AttendantInfo>> getPhotoByType(
      {int shopId, String type, int workDate}) async {
    var db = new DatabaseHelper();
    String sql = "select * from  Attendants where shopId = " +
        shopId.toString() +
        " and attendantType = " +
        type +
        " and attendantDate =" +
        workDate.toString();
    List<Map> data = await db.getList(sql);
    List<AttendantInfo> lst =
        data.map((Map e) => AttendantInfo.fromMap(e)).toList();
    if (lst != null && lst.length != 0) {
      return lst;
    } else {
      return null;
    }
  }

  static Future<List<AttendantInfo>> getAttendantPhotos(
      {int shopId, int workDate}) async {
    var db = new DatabaseHelper();
    String sql = "select * from  Attendants where shopId = " +
        shopId.toString() +
        " and attendantType in (0,1)" +
        " and attendantDate =" +
        workDate.toString();
    List<Map> data = await db.getList(sql);
    List<AttendantInfo> lst =
        // ignore: always_specify_types
        data.map((Map e) => AttendantInfo.fromMap(e)).toList();
    if (lst != null && lst.length != 0) {
      return lst;
    } else {
      return null;
    }
  }

  static insertAttendantPhoto(AttendantInfo photo) {
    var db = new DatabaseHelper();
    db.insertRow(TableNames.attendant, photo);
  }

  static Future<AttendantInfo> getOverView(int shopId, int photoDate) async {
    var db = new DatabaseHelper();
    String sql = "select * from Attendants where shopId = " +
        shopId.toString() +
        " and attendantType = 1000 and attendantDate = " +
        photoDate.toString() +
        " order by attendantTime desc";
    List<Map> data = await db.getList(sql);
    List<AttendantInfo> lst =
        // ignore: always_specify_types
        data.map((Map e) => AttendantInfo.fromMap(e)).toList();
    if (lst != null && lst.length > 0) {
      return lst[0];
    }
    return new AttendantInfo();
  }

  static Future<int> insertOverView(AttendantInfo photo) async {
    var db = new DatabaseHelper();
    int intResult = await db.insertRow(TableNames.attendant, photo);
    return intResult;
  }

  static Future<List<PhotoInfo>> getPhotoKPIs(
      {int workId, int itemId, int kpiId}) async {
    var db = new DatabaseHelper();
    String sql = "";
    if (itemId != null && kpiId != null) {
      sql += "select * from  Photo where workId = " +
          workId.toString() +
          " and itemId =" +
          itemId.toString() +
          " and kpiId = " +
          kpiId.toString();
    } else if (itemId == null && kpiId != null) {
      sql += "select * from  Photo where workId = " +
          workId.toString() +
          " and kpiId = " +
          kpiId.toString();
    } else {
      sql += "select * from  Photo where workId = " + workId.toString();
    }

    List<Map> data = await db.getList(sql);
    List<PhotoInfo> lst = data.map((Map e) => PhotoInfo.fromMap(e)).toList();
    if (lst != null && lst.length != 0) {
      return lst;
    } else {
      return null;
    }
  }

  static Future<int> insertPhotoKPI(PhotoInfo photo) async {
    var db = new DatabaseHelper();
    int intResult = await db.insertRow(TableNames.photo, photo);
    return intResult;
  }
}
