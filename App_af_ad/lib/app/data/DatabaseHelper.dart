import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/Keys.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'TableEntity.dart';
import 'TableNames.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => (_instance);
  static Database _db;

  DatabaseHelper.internal();

  // ignore: unused_element
  DatabaseHelper._();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  void refersh() {
    _db = null;
  }

  initDb() async {
    LoginInfo user = await Shared.getUser();
    int version = int.parse(await Utility.getVersion());

    String path = await FileUtils.getExternalStoragePath();
    if (Platform.isAndroid) {
      path = join(path, Keys.DATA_FOLDER_NAME);
      Directory directory = new Directory(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
    String dataPath =
        join(path,Keys.DATA_FOLDER_NAME +  '_' + user.employeeId.toString() + '.db');
    Database _dbb = await openDatabase(dataPath, version: version, onCreate: _onCreate);
    return _dbb;
  }

  void _onCreate(Database db, int newVersion) async {
    String rowId = 'rowId INTEGER PRIMARY KEY AUTOINCREMENT';

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.masterList +
          '(' +
          rowId +
          ', listCode TEXT, code TEXT, id INTEGER, name TEXT, nameVN TEXT, description TEXT, refCode TEXT, refId INTEGER , sortList INTEGER,parentType TEXT)');
      print("SQL_CREATE_EX-" + TableNames.masterList + "create ok");
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.masterList + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.shop +
          '(' +
          rowId +
          ', shopId INTEGER, shopName TEXT, address TEXT, contactName TEXT, phone TEXT, latitude DOUBLE  ,longitude DOUBLE ,shopType TEXT ,accuracy DOUBLE, photo TEXT, workDate INTEGER,'
              'shopCode TEXT, supportAudit TEXT,wpDescription TEXT,status INTEGER,salesName TEXT,salesPhone TEXT,formatName TEXT,sFOSA INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.shop + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.workResult +
          '(' +
          rowId +
          ', shopId INTEGER, shopFormatId INTEGER, workDate INTEGER, auditResult INTEGER, shopType TEXT, shopName TEXT,'
              ' workTime TEXT, isSave INTEGER, isDone INTEGER, isUpload INTEGER, comment TEXT)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.workResult + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.photo +
          '(' +
          rowId +
          ', photoPath TEXT, photoType TEXT, workDate INTEGER, photoTime INTEGER, workId INTEGER, shopId INTEGER, uploaded INTEGER, kpiId INTEGER, itemId INTEGER,'
              ' photoServer TEXT, frame INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.photo + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.attendant +
          '(' +
          rowId +
          ', shopId INTEGER, workId INTEGER, attendantDate INTEGER, attendantType INTEGER, attendantTime INTEGER, latitude DOUBLE, longitude DOUBLE, accuracy DOUBLE, attendantPhoto TEXT ,photoServer TEXT, uploaded INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.attendant + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiSurvey +
          '(' +
          rowId +
          ', surveyId INTEGER, kpiId INTEGER, name TEXT, desc TEXT, type TEXT, answer1 TEXT, descA1 TEXT, type1 TEXT, shopFormatId INTEGER ,imageMin INTEGER, imageMax INTEGER, groups TEXT, surveyOrder INTEGER, minData INTEGER, maxData INTEGER,photo TEXT)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiSurvey + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiSurveyDetail +
          '(' +
          rowId +
          ', sdId INTEGER, surveyId INTEGER, name TEXT, desc TEXT, type TEXT,imageMin INTEGER, imageMax INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiSurvey + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiSurveyAnswer +
          '(' +
          rowId +
          ', id INTEGER, surveyId INTEGER, name TEXT, kpiId INTEGER, notCheck INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiSurvey + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpisurveyResult +
          '(' +
          rowId +
          ', comment TEXT, workId INTEGER, surveyId INTEGER, value INTEGER, textValue TEXT)');
    } catch (ex) {
      print(
          "SQL_CREATE_EX-" + TableNames.kpisurveyResult + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiOSA +
          '(' +
          rowId +
          ', productId INTEGER, shopFormatId INTEGER, checkPrice INTEGER, targetOSA INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiOSA + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiOSAResult +
          '(' +
          rowId +
          ', workId INTEGER, productId INTEGER, osaValue INTEGER,layerValue INTEGER, comment TEXT)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiOSAResult + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.product +
          '(' +
          rowId +
          ', productId INTEGER, productName TEXT, milkPowder TEXT, keyBrand TEXT, brand TEXT,catId INTEGER,rate INTEGER, segment TEXT, segment2 TEXT, segment4 TEXT, photo TEXT, package TEXT, sortlist INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.product + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiPosm +
          '(' +
          rowId +
          ', shopId INTEGER, posmId INTEGER, posmName TEXT, photo TEXT, quantity INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiPosm + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiPosmResult +
          '(' +
          rowId +
          ', workId INTEGER, posmId INTEGER, target INTEGER, comment TEXT, value INTEGER,status INTEGER, quantity INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiPosmResult + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.audio +
          '(' +
          rowId +
          ', workId INTEGER, audioPath TEXT, audioLocal TEXT, uploaded INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.audio + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiSurveyDetailResult +
          '(' +
          rowId +
          ', workId INTEGER, surveyId INTEGER, sdId INTEGER, value INTEGER)');
    } catch (ex) {
      print(
          "SQL_CREATE_EX-" + TableNames.kpisurveyResult + ": " + ex.toString());
    }

    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.evaluateResult +
          '(' +
          rowId +
          ', shopId INTEGER, evaluateDate TEXT, kpiFormatName TEXT, resultName TEXT,resultStatus INTEGER)');
    } catch (ex) {
      print(
          "SQL_CREATE_EX-" + TableNames.evaluateResult + ": " + ex.toString());
    }
    try {
      await db.execute('CREATE TABLE IF NOT EXISTS ' +
          TableNames.coincollect +
          '(' +
          rowId +
          ', shopId INTEGER, month TEXT, kpiFormatName TEXT, coins INTEGER,quarter INTEGER)');
    } catch (ex) {
      print(
          "SQL_CREATE_EX-" + TableNames.coincollect + ": " + ex.toString());
    }

    try{
      //await updateData();
    } catch (ex) {
      print(
          "SQL_CREATE_EX-" + TableNames.coincollect + ": " + ex.toString());

    }
  }

  Future<void> updateData() async {
    var dbClient = await db;
    List<String> list = await listUpdate();
    for (int i = 0; i < list.length; i++) {
      try {
        await dbClient.execute(list[i]);
      } catch (e) {
        throw e;
      }
    }
  }

  Future<List<String>> listUpdate() async {
    String rowId = 'rowId INTEGER PRIMARY KEY AUTOINCREMENT';
    List<String> _list = new List<String>();

    // if (!await existsColumn(TableNames.kpiPosm, 'CheckReasonOOS')) {
    //   _list.add('ALTER TABLE ' +
    //       TableNames.SHOP_INFO +
    //       ' ADD COLUMN CheckReasonOOS INTEGER');
    // }

    try {
      _list.add('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiPromotion +
          '(' +
          rowId +
          ', shopId INTEGER, promotionId INTEGER, scheme TEXT, fromdate INTEGER, todate INTEGER,  productid INTEGER, productdescription TEXT)');
    } catch (ex) {
      throw ex;
    }

    try {
       _list.add('CREATE TABLE IF NOT EXISTS ' +
          TableNames.kpiPromotionResult +
          '(' +
          rowId +
          ', workId INTEGER, promotionId INTEGER, comment TEXT, value INTEGER,value1 INTEGER)');
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiPromotionResult + ": " + ex.toString());
    }

    try {
      if (!await existsColumn(TableNames.kpiOSAResult, 'footValue')) {
        _list.add('ALTER TABLE ' +
            TableNames.kpiOSAResult +
            ' ADD COLUMN footValue INTEGER');
      }
    } catch (ex) {
      print("SQL_CREATE_EX-" + TableNames.kpiPromotionResult + ": " + ex.toString());
    }

    return _list;
  }

  void closeDB() async {
    var dbClient = await db;
    try {
      dbClient.close();
    } catch (e) {}
  }

  static Future<String> getPath() async {
    LoginInfo user = await Shared.getUser();
    String path = await FileUtils.getExternalStoragePath();
    if (Platform.isAndroid) {
      path = join(path, Keys.DATA_FOLDER_NAME);
      Directory directory = new Directory(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
    return join(path, Keys.DATA_FOLDER_NAME + '_' + user.employeeId.toString() + '.db');
  }

  openDB() async {
    int version = int.parse(await Utility.getVersion());
    LoginInfo user = await Shared.getUser();
    String path = await FileUtils.getExternalStoragePath();
    if (Platform.isAndroid) {
      path = join(path, Keys.DATA_FOLDER_NAME);
      Directory directory = new Directory(path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    }
    return await openDatabase(
        join(path, Keys.DATA_FOLDER_NAME + '_' + user.toString() + '.db'),
        version: version,
        onCreate: _onCreate);
  }

  Future<int> deleteAll(String tableName) async {
    try {
      var dbClient = await db;
      int rows = await dbClient.rawDelete('DELETE FROM $tableName');
      return rows;
    } catch (ex) {
      return null;
    }
  }

  Future<List<Map>> getList(String sql) async {
    try {
      var dbClient = await db;
      return await dbClient.rawQuery(sql);
    } catch (ex) {
      throw ex;
    }
  }

  Future<void> execute(String sql) async {
    var dbClient = await db;
    return await dbClient.execute(sql);
  }

  Future<int> insertRow(String _tableName, BaseInfo baseInfo) async {
    var dbClient = await db;
    return await dbClient.insert(_tableName, baseInfo.toMap());
  }

  Future<int> insertMultiRow(String _tableName, List<BaseInfo> baseInfo) async {
    var dbClient = await db;
    int rows = 0;
    await dbClient.transaction((txn) async {
      Batch batch = txn.batch();
      try {
        for (var val in baseInfo) {
          batch.insert(_tableName, val.toMap());
          rows++;
        }
      } on Exception catch (exception) {
        print("sql_insert_multi_row:" + exception.toString());
      } finally {
        await batch.commit();
      }
    });
    return rows;
  }

  Future<int> updateTableHasrowId(String tableName, BaseInfo baseInfo) async {
    var dbClient = await db;
    return await dbClient.update(tableName, baseInfo.toMap(),
        where: "rowId = ?", whereArgs: [baseInfo.rowId]);
  }

  Future<int> updateTableHasKey(String tableName, BaseInfo baseInfo,
      String whereFields, List<dynamic> valueUpdate) async {
    var dbClient = await db;
    return await dbClient.update(tableName, baseInfo.toMap(),
        where: whereFields, whereArgs: valueUpdate);
  }

  Future<List<String>> getTableColumns(String tableName) async {
    List<String> column = new List.empty(growable: true);
    String sql = "pragma table_info (" + tableName + ")";
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      List<TableEntity> _listColumn =
          data.map((e) => TableEntity.fromMap(e)).toList();
      if (_listColumn != null && _listColumn.length > 0) {
        for (TableEntity entity in _listColumn) {
          column.add(entity.name);
        }
      }
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
    }
    return column;
  }

  Future<bool> existsColumn(String tableName, String columnName) async {
    List<String> list = await getTableColumns(tableName);
    if (list != null && list.length > 0) {
      for (String column in list) {
        if (column == columnName) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }
}
