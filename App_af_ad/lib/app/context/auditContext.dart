import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/CoinCollectInfo.dart';
import 'package:syngentaaudit/app/base/EvaluateResultInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/OsaResultInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/PosmResult.dart';
import 'package:syngentaaudit/app/base/PromotionResult.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';
import 'package:syngentaaudit/app/base/SurveyDetailResultInfo.dart';
import 'package:syngentaaudit/app/base/SurveyResultInfo.dart';
import 'package:syngentaaudit/app/base/UploadInfo.dart';
import 'package:syngentaaudit/app/base/UploadedItemInfo.dart';
import 'package:syngentaaudit/app/context/photoContext.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/AttendantInfo.dart';
import 'package:syngentaaudit/app/models/OsaResultModel.dart';
import 'package:syngentaaudit/app/models/PosmResultModel.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/PromotionResultModel.dart';
import 'package:syngentaaudit/app/models/SurveyDetailResultModel.dart';
import 'package:syngentaaudit/app/models/SurveyResultModel.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

class AuditContext {
  static Future<List<UploadInfo>> getUpload() async {
    String sql =
        "select s.comment,s.rowId as workId, s.shopId,s.shopName,s.workDate,s.workTime,s.shopFormatId,s.auditResult,s.shopType from WorkResult s where (s.isUpload is null or s.isUpload <> 1) and s.isDone=1 and s.shopId in (select shopId from Attendants where attendantType = 1) ORDER BY s.workDate DESC";
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => UploadInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<void> updateWorkResultDone(int workId) async {
    String sql =
        "update WorkResult set isUpload = 1 where rowId = " + workId.toString();
    var db = new DatabaseHelper();
    await db.execute(sql);
  }

  static Future<List<AttendantInfo>> getAttendantUpload(int workId) async {
    String sql =
        "select * from Attendants a where (a.uploaded is null or a.uploaded<>1) and a.workId=" +
            workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => AttendantInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<PhotoInfo>> getPhotoUpload(int workId) async {
    String sql =
        "select * from Photo p where (p.uploaded is null or p.uploaded<>1) and p.workId=" +
            workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => PhotoInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<AudioInfo>> getAudioUpload(int workId) async {
    String sql =
        "select * from Audios p where (p.uploaded is null or p.uploaded<>1) and p.workId=" +
            workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => AudioInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<OsaResultInfo>> getOsaUpload(int workId) async {
    String sql =
        "select * from KPIOSAResult p where p.workId=" + workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => OsaResultInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<PosmResultInfo>> getPosmUpload(int workId) async {
    String sql =
        "select * from KPIPosmResult p where p.workId=" + workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => PosmResultInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }
  static Future<List<PromotionResultInfo>> getPromotionUpload(int workId) async {
    String sql =
        "select * from "+TableNames.kpiPromotionResult+" p where p.workId=" + workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      print("SQLDataPromo: " + data.first.toString());
      return data.map((e) => PromotionResultInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<SurveyResultInfo>> getSurveyResultUpload(
      int workId) async {
    String sql =
        "select * from KPISurveyResult p where p.workId=" + workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => SurveyResultInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<SurveyDetailResultInfo>> getSurveyDetailResultInfoUpload(
      int workId) async {
    String sql = "select * from KPISurveyDetailResult p where p.workId=" +
        workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => SurveyDetailResultInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<UploadedItemInfo>> getUploadItem(int workId) async {
    String sql = "select count(*) as itemId,'Attendants' as itemName from Attendants a where (a.uploaded is null or a.uploaded<>1) and a.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'Photos' as itemName from Photo p where (p.uploaded is null or p.uploaded<>1) and p.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'Audios' as itemName from Audios p where (p.uploaded is null or p.uploaded<>1) and p.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'Osa' as itemName from KPIOSAResult p where p.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'Posm' as itemName from KPIPosmResult p where p.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'SurveyResult' as itemName from KPISurveyResult p where p.workId=" +
        workId.toString() +
        " union all select count(*) as itemId,'SurveyDetailResul' as itemName from KPISurveyDetailResult p where p.workId=" +
        workId.toString()+
        " union all select count(*) as itemId,'Promotion' as itemName from "+TableNames.kpiPromotionResult+" p where p.workId=" +
        workId.toString();
    print("SQL: " + sql);
    try {
      var db = new DatabaseHelper();
      var data = await db.getList(sql);
      return data.map((e) => UploadedItemInfo.fromMap(e)).toList();
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<ShopInfo>> getAllShopToDay() async {
    DatabaseHelper db = new DatabaseHelper();
    String sql = "select * from ShopInfo s where s.workDate = " +
        DateTimes.today().toString();
    var data = await db.getList(sql);

    List<ShopInfo> lst = data.map((Map e) => ShopInfo.fromMap(e)).toList();
    sql = "select * from WorkResult where workDate = " +
        DateTimes.today().toString();
    data = await db.getList(sql);
    List<WorkResultInfo> wrs =
        data.map((Map e) => WorkResultInfo.fromMap(e)).toList();

    sql = "select * from WorkResult where workDate = " +
        DateTimes.today().toString();
    if (lst != null && lst.length > 0 && wrs != null && wrs.length > 0) {
      for (ShopInfo shop in lst) {
        for (WorkResultInfo wr in wrs) {
          if (shop.shopId == wr.shopId) {
            if (wr.isUpload != null && wr.isUpload) {
              shop.isUpload = true;
            }
            if (wr.isDone != null && wr.isDone) {
              shop.locked = true;
            }
          }
        }
      }
    }
    return lst;
  }

  static Future<WorkResultInfo> setAudit(WorkResultInfo audit) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sql = "select * from WorkResult where shopId = " +
          audit.shopId.toString() +
          " and workDate = " +
          audit.workDate.toString();
      var data = await db.getList(sql);
      List<WorkResultInfo> lst =
          data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        db.updateTableHasrowId(TableNames.workResult, audit);
        String sql = "select * from WorkResult where shopId = " +
            audit.shopId.toString() +
            " and workDate = " +
            audit.workDate.toString();
        var data = await db.getList(sql);
        List<WorkResultInfo> lst =
            data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
        return lst[0];
      } else {
        await db.insertRow(TableNames.workResult, audit);
        String sql = "select * from WorkResult where shopId = " +
            audit.shopId.toString() +
            " and workDate = " +
            audit.workDate.toString();
        var data = await db.getList(sql);
        List<WorkResultInfo> lst =
            data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
        return lst[0];
      }
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<WorkResultInfo> getAudit(ShopInfo shop) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sql = "select * from WorkResult where shopId = " +
          shop.shopId.toString() +
          " and workDate = " +
          shop.workDate.toString();
      var data = await db.getList(sql);
      List<WorkResultInfo> lst =
          data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
      return lst[0];
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<WorkResultInfo> lockAudit(WorkResultInfo audit) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sql = "select * from WorkResult where shopId = " +
          audit.shopId.toString() +
          " and workDate = " +
          audit.workDate.toString();
      var data = await db.getList(sql);
      List<WorkResultInfo> lst =
          data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        db.updateTableHasrowId(TableNames.workResult, audit);
        String sql = "select * from WorkResult where shopId = " +
            audit.shopId.toString() +
            " and workDate = " +
            audit.workDate.toString();
        var data = await db.getList(sql);
        List<WorkResultInfo> lst =
            data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
        return lst[0];
      }
      return audit;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return audit;
    }
  }

  static Future<WorkResultInfo> rollBackAudit(WorkResultInfo audit) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String deleteImgOut = "delete from Attendants where attendantDate = " +
          audit.workDate.toString() +
          " and shopId = " +
          audit.shopId.toString() +
          " and attendantType = 1 and uploaded <>1";
      await db.getList(deleteImgOut);
      String sql = "select * from WorkResult where shopId = " +
          audit.shopId.toString() +
          " and workDate = " +
          audit.workDate.toString();
      var data = await db.getList(sql);
      List<WorkResultInfo> lst =
          data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        db.updateTableHasrowId(TableNames.workResult, audit);
        String sql = "select * from WorkResult where shopId = " +
            audit.shopId.toString() +
            " and workDate = " +
            audit.workDate.toString();
        var data = await db.getList(sql);
        List<WorkResultInfo> lst =
            data.map((Map e) => WorkResultInfo.fromMap(e)).toList();
        return lst[0];
      }
      return audit;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return audit;
    }
  }

  static Future<List<MasterInfo>> getMasterList(String listCode) async {
    try {
      var db = new DatabaseHelper();
      String sql = "select * from MasterList where listCode = '" +
          listCode +
          "' order by sortList";
      var data = await db.getList(sql);
      List<MasterInfo> lst =
          data.map((Map e) => MasterInfo.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<MasterInfo>> getMasterListWithCode(
      String listCode, String code) async {
    try {
      var db = new DatabaseHelper();
      String sql = "select * from MasterList where listCode = '" +
          listCode +
          "' and code = '" +
          code +
          "' " +
          " order by sortList";
      var data = await db.getList(sql);
      List<MasterInfo> lst =
          data.map((Map e) => MasterInfo.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<MasterInfo>> getKPIList(
      {String listCode, WorkResultInfo work, ShopInfo shop}) async {
    try {
      int itemMaxSurvey = 0;
      var db = new DatabaseHelper();
      String sql = "select * from MasterList where listCode = '" +
          listCode +
          "' and refCode = '" +
          work.shopId.toString() +
          "' order by sortList";
      var data = await db.getList(sql);
      List<MasterInfo> lst =
          data.map((Map e) => MasterInfo.fromMap(e)).toList();
      List<PhotoInfo> photoTemp =
          await PhotoContext.getPhotoKPIs(workId: work.rowId);
      if (lst != null && lst.length != 0) {
        for (MasterInfo kpi in lst) {
          if (kpi.refId == 1) {
            List<SurveyResultModel> lstTemp =
                await AuditContext.getSurveyResult(work, kpi.id);
            List<SurveyAnswerInfo> lstAns =
                await AuditContext.getSurveyAnswer(kpi.id);
            kpi.kpiStatus = 0;
            if (lstTemp != null && lstTemp.length != 0) {
              int haveResult = 0;
              for (SurveyResultModel item in lstTemp) {
                if (!ExString(item.type).isNullOrWhiteSpace() &&
                    (!ExString(item.value.toString()).isNullOrWhiteSpace() ||
                        !ExString(item.textValue.toString())
                            .isNullOrWhiteSpace())) {
                  haveResult = 1;
                  break;
                }
              }
              List<PhotoInfo> lstPhotoKPI = new List.empty(growable: true);
              if (photoTemp != null && photoTemp.length != 0) {
                lstPhotoKPI = photoTemp
                    .where((PhotoInfo e) => e.kpiId == kpi.id)
                    .toList();
                if (lstPhotoKPI != null && lstPhotoKPI.length != 0) {
                  haveResult = 1;
                }
              }

              if (haveResult == 1) {
                for (SurveyResultModel item in lstTemp) {
                  if (!ExString(item.type).isNullOrWhiteSpace() &&
                      (item.type == 'N') &&
                      ExString(item.value.toString()).isNullOrWhiteSpace()) {
                    kpi.kpiStatus = 1;
                    break;
                  } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                      (item.type == 'R')) {
                    if (ExString(item.value.toString()).isNullOrWhiteSpace()) {
                      kpi.kpiStatus = 1;
                      break;
                    } else if (item.value == 1) {
                      List<SurveyDetailResultModel> lstDetailTemp =
                          await AuditContext.getSurveyDetail(
                              work, item.surveyId);
                      if (lstDetailTemp != null && lstDetailTemp.length != 0) {
                        for (SurveyDetailResultModel detail in lstDetailTemp) {
                          if (ExString(detail.value.toString())
                              .isNullOrWhiteSpace()) {
                            kpi.kpiStatus = 1;
                            break;
                          }
                        }
                      }
                    }
                  } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                      item.type == 'S') {
                    if (!ExString(item.value.toString()).isNullOrWhiteSpace()) {
                      if (lstAns != null && lstAns.length != 0) {
                        for (SurveyAnswerInfo an in lstAns) {
                          if (an.id == item.value &&
                              item.surveyId == an.surveyId &&
                              an.notCheck == 1) {
                            kpi.kpiStatus = 1;
                            break;
                          }
                        }
                      } else {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    } else {
                      kpi.kpiStatus = 1;
                      break;
                    }
                  } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                      (item.type == 'T') &&
                      ExString(item.textValue.toString())
                          .isNullOrWhiteSpace()) {
                    kpi.kpiStatus = 1;
                    break;
                  }
                  if (item.imageMin != null && item.imageMin != 0) {
                    if (item.value != 0 || item.surveyId == 5) {
                      List<PhotoInfo> lstPhotoByItem =
                          new List.empty(growable: true);
                      if (photoTemp != null && photoTemp.length != 0) {
                        lstPhotoByItem = photoTemp
                            .where((PhotoInfo e) => item.surveyId == e.itemId)
                            .toList();
                        if (lstPhotoByItem != null &&
                            lstPhotoByItem.length != 0) {
                          if (lstPhotoByItem.length < item.imageMin) {
                            kpi.kpiStatus = 1;
                            break;
                          }
                        } else {
                          kpi.kpiStatus = 1;
                          break;
                        }
                      } else {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    }
                  }
                  kpi.kpiStatus = 2;
                }
              }
            } else {
              kpi.kpiStatus = 0;
            }
          } else {
            if (kpi.id == 2) {
              //PNG
              int haveResult = 0;
              int itemMaxSurvey = 0;
              kpi.kpiStatus = 0;

              List<OsaResultModel> lstOsaTemp =
                  await AuditContext.getOsaResult(work, shop);
              if (lstOsaTemp != null && lstOsaTemp.length != 0) {
                for (OsaResultModel item in lstOsaTemp) {
                  if (!ExString(item.osaValue.toString())
                      .isNullOrWhiteSpace()) {
                    haveResult = 1;
                    break;
                  }
                }
                List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
                if (photoTemp != null && photoTemp.length != 0) {
                  lstPhotoByItem = photoTemp
                      .where((PhotoInfo e) => kpi.id == e.kpiId)
                      .toList();
                  if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                    haveResult = 1;
                  }
                }
                if (haveResult == 1) {
                  String keyBrand ="";
                  List<OsaResultModel> l_brand_photo = <OsaResultModel>[];
                  for (OsaResultModel osa in lstOsaTemp) {
                    if (!ExString(osa.keyBrand).isNullOrWhiteSpace()) {
                      if (osa.keyBrand != keyBrand) {
                        keyBrand = osa.keyBrand;
                        osa.showKeyBrand = 1;
                        OsaResultModel osaBrand = OsaResultModel(productId: osa.productId,keyBrand: osa.keyBrand);
                        l_brand_photo.add(osaBrand);
                      } else {
                        osa.showKeyBrand = 0;
                      }
                    }
                    if (!ExString(osa.segment).isNullOrWhiteSpace() &&
                        osa.segment.contains("SURVEY") ) {
                      itemMaxSurvey++;
                    }
                  }

                  for (OsaResultModel osa in lstOsaTemp) {
                    if (ExString(osa.osaValue.toString())
                            .isNullOrWhiteSpace()
                        ) {

                      kpi.kpiStatus = 1;
                      break;
                    }
                    else if(shop.shopType.endsWith("MT") && osa.osaValue >0 && !osa.segment.endsWith("SURVEY"))
                    {
                      if(ExString(osa.layerValue.toString())
                          .isNullOrWhiteSpace() || (osa.layerValue != null && osa.layerValue ==0))
                      {
                        kpi.kpiStatus = 1;
                        break;
                      }
                      if(!ExString(osa.footid.toString())
                          .isNullOrWhiteSpace())
                        {
                          if(ExString(osa.footValue.toString())
                              .isNullOrWhiteSpace() || (osa.footValue != null && osa.footValue ==0))
                          {
                            kpi.kpiStatus = 1;
                            break;
                          }
                        }

                    }
                    if(osa.osaValue > 0)
                    {
                      for (OsaResultModel osa_b_p in l_brand_photo) {
                        if(osa.keyBrand == osa_b_p.keyBrand)
                          osa_b_p.osaValue = 1;
                      }
                    }
                    if (!ExString(osa.keyBrand).isNullOrWhiteSpace()) {
                      if (osa.keyBrand != keyBrand) {
                        keyBrand = osa.keyBrand;
                      } else {
                        osa.keyBrand = "";
                      }
                    }
                    // check hinh o cau survey so 4
                    if (osa.productId == itemMaxSurvey) {
                      List<PhotoInfo> lstImg = lstPhotoByItem
                          .where((PhotoInfo e) => e.itemId == osa.productId)
                          .toList();
                      if (lstImg == null ||
                          (lstImg != null && lstImg.length == 0)) {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    } else if (!ExString(osa.keyBrand).isNullOrWhiteSpace() &&
                        !osa.segment.contains("SURVEY")) {
                      List<PhotoInfo> lstImg = lstPhotoByItem
                          .where((PhotoInfo e) => e.itemId == osa.productId)
                          .toList();
                      if (lstImg == null ||
                          (lstImg != null && lstImg.length == 0)) {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    }

                    kpi.kpiStatus = 2;
                  }
                  // Check hình by keybrand
                  //print(l_brand_photo[0].keyBrand  + "/" + l_brand_photo[0].osaValue.toString());
                  //print(l_brand_photo[1].keyBrand  + "/" + l_brand_photo[1].osaValue.toString());
                  //print(l_brand_photo[2].keyBrand  + "/" + l_brand_photo[2].osaValue.toString());
                  for (OsaResultModel osa in l_brand_photo) {
                    if(!ExString(osa.osaValue.toString()).isNullOrWhiteSpace() && osa.osaValue >0 ) {
                      List<PhotoInfo> lstImg = lstPhotoByItem
                          .where((PhotoInfo e) => e.itemId == osa.productId)
                          .toList();
                      if (lstImg == null ||
                          (lstImg != null && lstImg.length == 0)) {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    }
                  }
                }
              } else {
                kpi.kpiStatus = 0;
              }
            }
            if (kpi.id == 3) {
              //POSM
              int haveResult = 0;
              kpi.kpiStatus = 0;
              List<MasterInfo> lstAns =
                  await AuditContext.getMasterList('${kpi.code}OPTION');
              List<PosmResultModel> lstTemp =
                  await AuditContext.getPosmResult(work);
              if (lstTemp != null && lstTemp.length != 0) {
                for (PosmResultModel posm in lstTemp) {
                  if (!ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                    haveResult = 1;
                    break;
                  }
                }
                List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
                if (photoTemp != null && photoTemp.length != 0) {
                  lstPhotoByItem = photoTemp
                      .where((PhotoInfo e) => kpi.id == e.kpiId)
                      .toList();
                  if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                    haveResult = 1;
                  }
                }
                if (haveResult == 1) {
                  for (PosmResultModel posm in lstTemp) {
                    int notStatus = 0;
                    if (ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                      kpi.kpiStatus = 1;
                      break;
                    }
                    if (posm.value == 1) {
                      if (!ExString(posm.status.toString())
                              .isNullOrWhiteSpace() &&
                          !ExString(posm.quantity.toString())
                              .isNullOrWhiteSpace()) {
                        if (lstAns != null && lstAns.length != 0) {
                          for (MasterInfo ans in lstAns) {
                            if (ans.id == posm.status) {
                              if (ans.refId == 1) {
                                notStatus = 1;
                                break;
                              }
                            }
                          }
                        }
                        if (notStatus == 1) {
                          kpi.kpiStatus = 1;
                          break;
                        }
                      } else if (ExString(posm.status.toString())
                              .isNullOrWhiteSpace() ||
                          ExString(posm.quantity.toString())
                              .isNullOrWhiteSpace()) {
                        kpi.kpiStatus = 1;
                        break;
                      }

                      if (lstPhotoByItem != null &&
                          lstPhotoByItem.length != 0) {
                        List<PhotoInfo> lstImg = lstPhotoByItem
                            .where((PhotoInfo e) => e.itemId == posm.posmId)
                            .toList();
                        if (lstImg == null ||
                            (lstImg != null && lstImg.length == 0)) {
                          kpi.kpiStatus = 1;
                          break;
                        }
                      } else {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    }
                    kpi.kpiStatus = 2;
                  }
                }
              } else {
                kpi.kpiStatus = 0;
              }
            }
            if (kpi.id == 7) {
              //Promotion
              int haveResult = 0;
              kpi.kpiStatus = 0;
              List<PromotionResultModel> lstTemp =
              await AuditContext.getPromotionResult(work);
              if (lstTemp != null && lstTemp.length != 0) {
                for (PromotionResultModel posm in lstTemp) {
                  if (!ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                    haveResult = 1;
                    break;
                  }
                }
                List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
                if (photoTemp != null && photoTemp.length != 0) {
                  lstPhotoByItem = photoTemp
                      .where((PhotoInfo e) => kpi.id == e.kpiId)
                      .toList();
                  if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                    haveResult = 1;
                  }
                }
                if (haveResult == 1) {
                  for (PromotionResultModel posm in lstTemp) {
                    int notStatus = 0;
                    if (ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                      kpi.kpiStatus = 1;
                      break;
                    }
                    if (posm.value == 1) {
                      if (ExString(posm.value1.toString())
                          .isNullOrWhiteSpace() ) {
                          kpi.kpiStatus = 1;
                          break;
                      }
                      if (lstPhotoByItem != null &&
                          lstPhotoByItem.length != 0) {
                        List<PhotoInfo> lstImg = lstPhotoByItem
                            .where((PhotoInfo e) => e.itemId == posm.promotionId)
                            .toList();
                        if (lstImg == null ||
                            (lstImg != null && lstImg.length == 0)) {
                          kpi.kpiStatus = 1;
                          break;
                        }
                      } else {
                        kpi.kpiStatus = 1;
                        break;
                      }
                    }
                    kpi.kpiStatus = 2;
                  }
                }
              } else {
                kpi.kpiStatus = 0;
              }
            }
          }
        }
      }
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<SurveyAnswerInfo>> getSurveyAnswer(int kpiId) async {
    try {
      var db = new DatabaseHelper();
      String sql = "select * from KPISurveyAnswer where kpiId = " +
          kpiId.toString() +
          " order by rowId";
      var data = await db.getList(sql);
      List<SurveyAnswerInfo> lst =
          data.map((Map e) => SurveyAnswerInfo.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<SurveyResultModel>> getSurveyResult(
      WorkResultInfo work, int kpiId) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sql = "select ms.code as kpi,ks.kpiId,ks.name,ks.type,ks.surveyId," +
          work.rowId.toString() +
          " workId,ks.desc," +
          " ks.imageMin,ks.imageMax,case when sr.value is null then null else sr.value end value,sr.textValue," +
          " sr.comment,ks.minData,ks.maxData,ks.groups " +
          " from KPISurvey ks left join KPISurveyResult sr on sr.workId=" +
          work.rowId.toString() +
          " and sr.surveyId=ks.surveyId" +
          " left join MasterList ms on ms.id = ks.kpiId and ms.listCode = 'KPI' " +
          " where (ks.shopFormatId = 0 or ks.shopFormatId is NULL) and ks.kpiId= " +
          kpiId.toString() +
          " and ms.refCode = " +
          work.shopId.toString() +
          " order by surveyOrder asc";
      List<Map<dynamic, dynamic>> data = await db.getList(sql);
      List<SurveyResultModel> lst =
          data.map((Map e) => SurveyResultModel.fromMap(e)).toList();
      return lst;
    } catch (e) {
      return <SurveyResultModel>[];
    }
  }

  static Future<List<EvaluateResultInfo>> getEvaluateResult(int shopId) async {
    try {
      var db = new DatabaseHelper();
      String sql =
          "select * from EvaluateResult where shopId = " + shopId.toString();
      var data = await db.getList(sql);
      List<EvaluateResultInfo> lst =
          data.map((Map e) => EvaluateResultInfo.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<CoinCollectInfo>> getCoinCollect(int shopId) async {
    try {
      var db = new DatabaseHelper();
      String sql =
          "select * from CoinCollectInfo where shopId = " + shopId.toString();
      var data = await db.getList(sql);
      List<CoinCollectInfo> lst =
          data.map((Map e) => CoinCollectInfo.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<List<SurveyDetailResultModel>> getSurveyDetail(
      WorkResultInfo work, int surveyId) async {
    try {
      var db = new DatabaseHelper();
      String sql =
          "select kd.surveyId,kd.sdId,kd.name,kd.type,kdr.rowId,kdr.value from KPISurveyDetail kd left join KPISurveyDetailResult kdr " +
              " on kd.sdId = kdr.sdId and kdr.workId = " +
              work.rowId.toString() +
              " where kd.surveyId = " +
              surveyId.toString();
      var data = await db.getList(sql);
      List<SurveyDetailResultModel> lst =
          data.map((Map e) => SurveyDetailResultModel.fromMap(e)).toList();
      return lst;
    } catch (ex) {
      print("SQL-EXCEPTION: " + ex.toString());
      return null;
    }
  }

  static Future<String> setData(
      WorkResultInfo work, SurveyResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect = "select * from KPISurveyResult as sd where workId = " +
          work.rowId.toString() +
          " and surveyId = " +
          item.surveyId.toString();
      var data = await db.getList(sqlSelect);
      List<SurveyResultInfo> lst =
          data.map((Map e) => SurveyResultInfo.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        SurveyResultInfo temp =
            new SurveyResultInfo(surveyId: item.surveyId, workId: work.rowId);
        temp.rowId = lst[0].rowId;
        temp.comment = item.comment;
        temp.value = item.value;
        temp.textValue = item.textValue;
        db.updateTableHasrowId(TableNames.kpisurveyResult, temp);
      } else {
        SurveyResultInfo temp = new SurveyResultInfo(
            comment: item.comment,
            surveyId: item.surveyId,
            value: item.value,
            workId: work.rowId);
        db.insertRow(TableNames.kpisurveyResult, temp);
      }
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<String> setDataDetail(
      WorkResultInfo work, SurveyDetailResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "select * from KPISurveyDetailResult as sd where workId = " +
              work.rowId.toString() +
              " and surveyId = " +
              item.surveyId.toString() +
              " and sdId =" +
              item.sdId.toString();
      var data = await db.getList(sqlSelect);
      List<SurveyDetailResultModel> lst =
          data.map((Map e) => SurveyDetailResultModel.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        SurveyDetailResultInfo temp = new SurveyDetailResultInfo(
            sdId: item.sdId, surveyId: item.surveyId);
        temp.rowId = lst[0].rowId;
        temp.value = item.value;
        db.updateTableHasrowId(TableNames.kpiSurveyDetailResult, temp);
      } else {
        SurveyDetailResultInfo temp = new SurveyDetailResultInfo(
            sdId: item.sdId,
            surveyId: item.surveyId,
            value: item.value,
            workId: work.rowId);
        db.insertRow(TableNames.kpiSurveyDetailResult, temp);
      }
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<String> deleteDataDetail(
      WorkResultInfo work, SurveyResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "delete from KPISurveyDetailResult as sd where workId = " +
              work.rowId.toString() +
              " and surveyId = " +
              item.surveyId.toString();
      await db.execute(sqlSelect);
      return "";
    } catch (e) {
      print("deleteError " + e.toString());
      return e.toString();
    }
  }

  static Future<List<PosmResultModel>> getPosmResult(
      WorkResultInfo work) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "select kp.shopId,kp.posmId,kp.posmName,kp.photo,kpr.workId,kpr.value,kpr.comment,kpr.status,kpr.quantity, kp.quantity as target from KPIPosm as kp " +
              "left join KPIPosmResult kpr on kp.posmId = kpr.posmId and kpr.workId = " +
              work.rowId.toString() +
              " where kp.shopId =" +
              work.shopId.toString();
      var data = await db.getList(sqlSelect);
      List<PosmResultModel> lst =
          data.map((Map e) => PosmResultModel.fromMap(e)).toList();
      return lst;
    } catch (e) {
      return <PosmResultModel>[];
    }
  }

  static Future<List<PromotionResultModel>> getPromotionResult(
      WorkResultInfo work) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "select kp.shopId,kp.promotionId,kp.scheme,kpr.workId,kpr.value,kpr.comment,kpr.value1 from "+TableNames.kpiPromotion+" as kp " +
              "left join "+TableNames.kpiPromotionResult+" kpr on kp.promotionId = kpr.promotionId and kpr.workId = " +
              work.rowId.toString() +
              " where kp.shopId =" +
              work.shopId.toString();
      var data = await db.getList(sqlSelect);
      print("promotionget:" + sqlSelect);
      print("promoresult:" + data.map((Map e) => PromotionResultModel.fromMap(e).toJson()).toString());
      List<PromotionResultModel> lst =
      data.map((Map e) => PromotionResultModel.fromMap(e)).toList();
      return lst;
    } catch (e) {
      return <PromotionResultModel>[];
    }
  }

  static Future<String> setDataPosm(
      WorkResultInfo work, PosmResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect = "select * from KPIPosmResult as sd where workId = " +
          work.rowId.toString() +
          " and posmId = " +
          item.posmId.toString();
      var data = await db.getList(sqlSelect);
      List<PosmResultModel> lst =
          data.map((Map e) => PosmResultModel.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        PosmResultModel temp = new PosmResultModel(
            shopId: work.shopId,
            posmId: item.posmId,
            posmName: item.posmName,
            workId: work.rowId);
        temp.rowId = lst[0].rowId;
        temp.comment = item.comment;
        temp.value = item.value;
        temp.status = item.status;
        temp.quantity = item.quantity;
        db.updateTableHasrowId(TableNames.kpiPosmResult, temp);
      } else {
        PosmResultModel temp = new PosmResultModel(
            posmId: item.posmId,
            posmName: item.posmName,
            comment: item.comment,
            value: item.value,
            status: item.status,
            quantity: item.quantity,
            workId: work.rowId);
        db.insertRow(TableNames.kpiPosmResult, temp);
      }
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<String> setDataPromotion(
      WorkResultInfo work, PromotionResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect = "select * from "+TableNames.kpiPromotionResult+" as sd where workId = " +
          work.rowId.toString() +
          " and promotionId = " +
          item.promotionId.toString();
      var data = await db.getList(sqlSelect);
      List<PromotionResultModel> lst =
      data.map((Map e) => PromotionResultModel.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        PromotionResultModel temp = new PromotionResultModel(
            shopId: work.shopId,
            promotionId: item.promotionId,
            scheme: item.scheme,
            workId: work.rowId);
        temp.rowId = lst[0].rowId;
        temp.comment = item.comment;
        temp.value = item.value;
        temp.value1 = item.value1;
        db.updateTableHasrowId(TableNames.kpiPromotionResult, temp);
      } else {
        PromotionResultModel temp = new PromotionResultModel(
            promotionId: item.promotionId,
            scheme: item.scheme,
            comment: item.comment,
            value: item.value,
            value1: item.value1,
            workId: work.rowId);
        db.insertRow(TableNames.kpiPromotionResult, temp);
      }
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<List<OsaResultModel>> getOsaResult(
      WorkResultInfo work, ShopInfo shop) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "select ka.productId,p.productName,ka.shopFormatId,ka.checkPrice,ka.targetOSA,p.milkPowder,p.keyBrand,p.brand,p.segment,p.photo as photo,p.sortlist,kas.rowId,kas.workId,kas.osaValue,kas.layerValue,kas.footValue, kas.comment,ml.id footid " +
              //",RANK () OVER ( PARTITION BY p.keyBrand ORDER BY p.segment,ka.productId ) showKeyBrand " +
              "from KPIOSA ka " +
              "LEFT join Products p on ka.productId = p.productId " +
              "LEFT join KPIOSAResult kas on ka.productId = kas.productId and kas.workId = " +
              work.rowId.toString() +
              " left join " + TableNames.masterList + " ml on ml.listCode='MT_PR_C' and ml.refId="+shop.shopId.toString()+" and ml.id = p.productId "
              " where ka.shopFormatId = " +
              shop.sFOSA.toString() +
              " order by p.keyBrand,p.segment,ka.productId";
      print("------------sqlSelect------------------");
      print(sqlSelect);
      print("------------sqlSelect------------------");
      var data = await db.getList(sqlSelect);

      List<OsaResultModel> lst =
          data.map((Map e) => OsaResultModel.fromMap(e)).toList();
      return lst;
    } catch (e) {
      print(e.toString());
      return <OsaResultModel>[];
    }
  }

  static Future<List<OsaResultModel>> getOsaResult_Summary(
      WorkResultInfo work, ShopInfo shop) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect =
          "select p.keyBrand, p.segment,sum(kr.osavalue) osaValue  from KPIOSAResult kr  left join Products p on p.ProductId = kr.ProductId " +
              " where workId = "+work.rowId.toString()+" and p.segment <> 'SURVEY' and ifnull(kr.osaValue,0) >0 group by p.keyBrand, p.segment order by p.keyBrand, p.segment " ;
      print(sqlSelect);
      var data = await db.getList(sqlSelect);
      List<OsaResultModel> lst =
      data.map((Map e) => OsaResultModel.fromMap(e)).toList();
      return lst;
    } catch (e) {
      return <OsaResultModel>[];
    }
  }

  static Future<String> setDataOsa(
      WorkResultInfo work, OsaResultModel item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      String sqlSelect = "select * from KPIOSAResult as sd where workId = " +
          work.rowId.toString() +
          " and productId = " +
          item.productId.toString();
      var data = await db.getList(sqlSelect);
      List<OsaResultModel> lst =
          data.map((Map e) => OsaResultModel.fromMap(e)).toList();
      if (lst != null && lst.length != 0) {
        OsaResultInfo temp =
            new OsaResultInfo(productId: item.productId, workId: work.rowId);
        temp.rowId = lst[0].rowId;
        temp.comment = item.comment;
        temp.osaValue = item.osaValue;
        if(temp.osaValue != null && temp.osaValue > 0) {
          temp.layerValue = item.layerValue;
          temp.footValue = item.footValue;
        }
        else {
          temp.layerValue = null;
          temp.footValue=null;
        }
        print(temp.toMap().toString());
        db.updateTableHasrowId(TableNames.kpiOSAResult, temp);
      } else {
        OsaResultInfo temp = new OsaResultInfo(
            productId: item.productId,
            comment: item.comment,
            osaValue: item.osaValue,
            layerValue: (item.osaValue != null && item.osaValue>0? item.layerValue:null),
            footValue: (item.osaValue != null && item.osaValue>0? item.footValue:null),
            workId: work.rowId);
        db.insertRow(TableNames.kpiOSAResult, temp);
      }
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<String> setAllDataOsa(
      WorkResultInfo work, List<OsaResultModel> item) async {
    try {
      DatabaseHelper db = new DatabaseHelper();
      db.insertMultiRow(TableNames.kpiOSAResult, item);
      return "";
    } catch (e) {
      print("updateError " + e.toString());
      return e.toString();
    }
  }

  static Future<int> deleteDataAudit(WorkResultInfo work) async {
    DatabaseHelper db = new DatabaseHelper();
    String sqlDeleteSurvey =
        "delete from KPISurveyResult where workId =" + work.rowId.toString();
    String sqlDeleteSurveyDetail =
        "delete from KPISurveyDetailResult where workId = " +
            work.rowId.toString();
    String sqlDeleteOsa =
        "delete from KPIOSAResult where workId = " + work.rowId.toString();
    String sqlDeletePosm =
        "delete from KPIPosmResult where workId = " + work.rowId.toString();
    String sqlDeletePhoto =
        "delete from Photo where workId = " + work.rowId.toString();
    await db.execute(sqlDeleteSurvey);
    await db.execute(sqlDeleteSurveyDetail);
    await db.execute(sqlDeleteOsa);
    await db.execute(sqlDeletePosm);
    await db.execute(sqlDeletePhoto);
    List<PhotoInfo> lst = await PhotoContext.getPhotoKPIs(workId: work.rowId);
    if (lst == null || lst.length == 0) {
      return 0;
    } else {
      return lst.length;
    }
  }

  static Future<List<AudioInfo>> getListAudio(WorkResultInfo work) async {
    var db = new DatabaseHelper();
    String sql = "select * from Audios where workId = " + work.rowId.toString();
    var data = await db.getList(sql);
    return  data.map((Map e) => AudioInfo.fromMap(e)).toList();
  }

  // ignore: missing_return
  static Future<String> checkData(
      {WorkResultInfo work, ShopInfo shop, String listCode = "KPI",int KPIId = 0}) async {
    var db = new DatabaseHelper();
    String sql = "select * from MasterList where listCode = '" +
        listCode +
        "' and refCode = '" +
        work.shopId.toString() +
        "' order by sortList";
    var data = await db.getList(sql);
    List<MasterInfo> lst = data.map((Map e) => MasterInfo.fromMap(e)).toList();
    List<PhotoInfo> photoTemp =
        await PhotoContext.getPhotoKPIs(workId: work.rowId);
    if (lst != null && lst.length != 0) {
      for (MasterInfo kpi in lst) {
        //Hotzone
        if (kpi.refId == 1 && (KPIId == 0 || KPIId ==1)) {
          List<SurveyResultModel> lstTemp =
              await AuditContext.getSurveyResult(work, kpi.id);
          List<SurveyAnswerInfo> lstAns =
              await AuditContext.getSurveyAnswer(kpi.id);
          if (lstTemp != null && lstTemp.length != 0) {
            for (SurveyResultModel item in lstTemp) {
              if (!ExString(item.type).isNullOrWhiteSpace() &&
                  (item.type == 'N') &&
                  ExString(item.value.toString()).isNullOrWhiteSpace()) {
                return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành.';
              } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                  (item.type == 'R')) {
                if (ExString(item.value.toString()).isNullOrWhiteSpace()) {
                  return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành.';
                } else if (item.value == 1) {
                  List<SurveyDetailResultModel> lstDetailTemp =
                      await AuditContext.getSurveyDetail(work, item.surveyId);
                  if (lstDetailTemp != null && lstDetailTemp.length != 0) {
                    for (SurveyDetailResultModel detail in lstDetailTemp) {
                      if (ExString(detail.value.toString())
                          .isNullOrWhiteSpace()) {
                        return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành các câu hỏi nhỏ.';
                      }
                    }
                  }
                }
              } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                  item.type == 'S') {
                if (!ExString(item.value.toString()).isNullOrWhiteSpace()) {
                  if (lstAns != null && lstAns.length != 0) {
                    for (SurveyAnswerInfo an in lstAns) {
                      if (an.id == item.value &&
                          item.surveyId == an.surveyId &&
                          an.notCheck == 1) {
                        return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành.';
                      }
                    }
                  } else {
                    return 'KPI ${kpi.name} - câu ${item.name} Không có danh sách câu trả lời.';
                  }
                } else {
                  return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành.';
                }
              } else if (!ExString(item.type).isNullOrWhiteSpace() &&
                  (item.type == 'T') &&
                  ExString(item.textValue.toString()).isNullOrWhiteSpace()) {
                return 'KPI ${kpi.name} - câu ${item.name} chưa hoàn thành.';
              }
              if (item.imageMin != null && item.imageMin != 0) {
                if (item.value != 0 || item.surveyId == 5) {
                  List<PhotoInfo> lstPhotoByItem =
                      new List.empty(growable: true);
                  if (photoTemp != null && photoTemp.length != 0) {
                    lstPhotoByItem = photoTemp
                        .where((PhotoInfo e) => item.surveyId == e.itemId)
                        .toList();
                    if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                      if (lstPhotoByItem.length < item.imageMin) {
                        return 'KPI ${kpi.name} - câu ${item.name} chưa chụp đủ hình theo yêu cầu ${lstPhotoByItem.length}/${item.imageMin}.';
                      }
                    } else {
                      return 'KPI ${kpi.name} - câu ${item.name} chưa chụp đủ hình theo yêu cầu 0/${item.imageMin}.';
                    }
                  } else {
                    return 'KPI ${kpi.name} - câu ${item.name} chưa chụp đủ hình theo yêu cầu 0/${item.imageMin}.';
                  }
                }
              }
            }
          }
        } else {
          if (kpi.id == 2 && (KPIId == 0 || KPIId ==2)) {
            //PNG
            int itemMaxSurvey = 0;
            List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
            if (photoTemp != null && photoTemp.length != 0) {
              lstPhotoByItem =
                  photoTemp.where((PhotoInfo e) => kpi.id == e.kpiId).toList();
            }
            String keyBrand ="";
            List<OsaResultModel> lstOsaTemp =
                await AuditContext.getOsaResult(work, shop);
            List<OsaResultModel> l_brand_photo = <OsaResultModel>[];
            for (OsaResultModel osa in lstOsaTemp) {
              if (!ExString(osa.keyBrand).isNullOrWhiteSpace()) {
                if (osa.keyBrand != keyBrand) {
                  keyBrand = osa.keyBrand;
                  osa.showKeyBrand = 1;
                  OsaResultModel osa_brand = OsaResultModel(productId: osa.productId,keyBrand: osa.keyBrand);
                  l_brand_photo.add(osa_brand);
                } else {
                  osa.showKeyBrand = 0;
                }
              }
              if (!ExString(osa.segment).isNullOrWhiteSpace() &&
                  osa.segment.contains("SURVEY") ) {
                itemMaxSurvey++;
              }
            }
            if (lstOsaTemp != null && lstOsaTemp.length != 0) {
              String keyBrand = "";
              for (OsaResultModel osa in lstOsaTemp) {
                if (ExString(osa.osaValue.toString())
                        .isNullOrWhiteSpace()
                    ) {
                  return 'KPI ${kpi.name} - câu ${osa.productName} chưa hoàn thành.';
                }
                else if(osa.osaValue > 0 && shop.shopType.endsWith("MT") && !osa.segment.endsWith("SURVEY"))
                {
                  if(ExString(osa.layerValue.toString())
                      .isNullOrWhiteSpace())
                      return 'KPI ${kpi.name} - câu ${osa.productName} chưa hoàn thành số lớp.';
                  else if (osa.layerValue ==0)
                      return 'KPI ${kpi.name} - câu ${osa.productName} nhập số lớp >0.';

                  // Có đk ks số chân
                  if(!ExString(osa.footid.toString())
                      .isNullOrWhiteSpace())
                    {
                      if(ExString(osa.footValue.toString())
                          .isNullOrWhiteSpace())
                        return 'KPI ${kpi.name} - câu ${osa.productName} chưa hoàn thành số chân.';
                      else if (osa.footValue ==0)
                        return 'KPI ${kpi.name} - câu ${osa.productName} nhập số chân >0.';
                    }
                }
                if(osa.osaValue > 0)
                  {
                    for (OsaResultModel osa_b_p in l_brand_photo) {
                      if(osa.keyBrand == osa_b_p.keyBrand)
                        osa_b_p.osaValue = 1;
                    }
                  }

                if (!ExString(osa.keyBrand).isNullOrWhiteSpace()) {
                  if (osa.keyBrand != keyBrand) {
                    keyBrand = osa.keyBrand;
                  } else {
                    osa.keyBrand = "";
                  }
                }
              }
              for (OsaResultModel osa in lstOsaTemp) {
                // check hinh o cau survey so 4
                if (osa.productId == itemMaxSurvey) {
                  List<PhotoInfo> lstImg = lstPhotoByItem
                      .where((PhotoInfo e) => e.itemId == osa.productId)
                      .toList();
                  if (lstImg == null ||
                      (lstImg != null && lstImg.length == 0)) {
                    return 'KPI ${kpi.name} - câu ${osa.productName} chưa chụp đủ hình theo yêu cầu 0/1.';
                  }
                } else if (!ExString(osa.keyBrand).isNullOrWhiteSpace() &&
                    !osa.segment.contains("SURVEY")) {
                  List<PhotoInfo> lstImg = lstPhotoByItem
                      .where((PhotoInfo e) => e.itemId == osa.productId)
                      .toList();
                  if (lstImg == null ||
                      (lstImg != null && lstImg.length == 0)) {
                    return 'KPI ${kpi.name} - câu ${osa.productName} chưa chụp đủ hình theo yêu cầu 0/1.';
                  }
                }

                // Check hình by keybrand
                for (OsaResultModel osa in l_brand_photo) {
                  if(!ExString(osa.osaValue.toString()).isNullOrWhiteSpace() && osa.osaValue >0 ) {
                    List<PhotoInfo> lstImg = lstPhotoByItem
                        .where((PhotoInfo e) => e.itemId == osa.productId)
                        .toList();
                    if (lstImg == null ||
                        (lstImg != null && lstImg.length == 0)) {
                      return 'KPI ${kpi.name} - Brand ${osa
                          .keyBrand} chưa chụp đủ hình theo yêu cầu 0/1.';
                    }
                  }
                }
              }
            }
          }
          if (kpi.id == 3 && (KPIId == 0 || KPIId ==3)) {
            //POSM
            List<MasterInfo> lstAns =
                await AuditContext.getMasterList('${kpi.code}OPTION');
            List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
            if (photoTemp != null && photoTemp.length != 0) {
              lstPhotoByItem =
                  photoTemp.where((PhotoInfo e) => kpi.id == e.kpiId).toList();
            }
            List<PosmResultModel> lstTemp =
                await AuditContext.getPosmResult(work);
            if (lstTemp != null && lstTemp.length != 0) {
              for (PosmResultModel posm in lstTemp) {
                int notStatus = 0;
                if (ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                  return 'KPI ${kpi.name} - câu ${posm.posmName} chưa hoàn thành.';
                }
                if (posm.value == 1) {
                  if (!ExString(posm.status.toString()).isNullOrWhiteSpace() &&
                      !ExString(posm.quantity.toString())
                          .isNullOrWhiteSpace()) {
                    if (lstAns != null && lstAns.length != 0) {
                      for (MasterInfo ans in lstAns) {
                        if (ans.id == posm.status) {
                          if (ans.refId == 1) {
                            notStatus = 1;
                            break;
                          }
                        }
                      }
                    }
                    if (notStatus == 1) {
                      return 'KPI ${kpi.name} - câu ${posm.posmName} chưa hoàn thành.';
                    }
                  } else if (ExString(posm.status.toString())
                          .isNullOrWhiteSpace() ||
                      ExString(posm.quantity.toString()).isNullOrWhiteSpace()) {
                    return 'KPI ${kpi.name} - câu ${posm.posmName} chưa hoàn thành.';
                  }

                  if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                    List<PhotoInfo> lstImg = lstPhotoByItem
                        .where((PhotoInfo e) => e.itemId == posm.posmId)
                        .toList();
                    if (lstImg == null ||
                        (lstImg != null && lstImg.length == 0)) {
                      return 'KPI ${kpi.name} - câu ${posm.posmName} chưa chụp đủ hình theo yêu cầu 0/1.';
                    }
                  } else {
                    return 'KPI ${kpi.name} - câu ${posm.posmName} chưa chụp đủ hình theo yêu cầu 0/1.';
                  }
                }
                // else if(posm.value ==0)
                //   {
                //     if (ExString(posm.comment.toString()).isNullOrWhiteSpace()) {
                //       return 'KPI ${kpi.name} - câu ${posm.posmName} cần ghi chú.';
                //     }
                //   }
              }
            }
          }

          if (kpi.id == 7 && (KPIId == 0 || KPIId ==7)) {
            //Promotion
            List<MasterInfo> lstAns =
            await AuditContext.getMasterList('${kpi.code}OPTION');
            List<PhotoInfo> lstPhotoByItem = new List.empty(growable: true);
            if (photoTemp != null && photoTemp.length != 0) {
              lstPhotoByItem =
                  photoTemp.where((PhotoInfo e) => kpi.id == e.kpiId).toList();
            }
            List<PromotionResultModel> lstTemp =
            await AuditContext.getPromotionResult(work);
            if (lstTemp != null && lstTemp.length != 0) {
              for (PromotionResultModel posm in lstTemp) {
                if (ExString(posm.value.toString()).isNullOrWhiteSpace()) {
                  return 'KPI ${kpi.name} - câu ${posm.scheme} chưa hoàn thành.';
                }
                if (posm.value == 1) {
                  if (ExString(posm.value1.toString()).isNullOrWhiteSpace()) {
                    return 'KPI ${kpi.name} - câu ${posm.scheme} chưa hoàn thành.';
                  }

                  if (lstPhotoByItem != null && lstPhotoByItem.length != 0) {
                    List<PhotoInfo> lstImg = lstPhotoByItem
                        .where((PhotoInfo e) => e.itemId == posm.promotionId)
                        .toList();
                    if (lstImg == null ||
                        (lstImg != null && lstImg.length == 0)) {
                      return 'KPI ${kpi.name} - câu ${posm.scheme} chưa chụp đủ hình theo yêu cầu 0/1.';
                    }
                  } else {
                    return 'KPI ${kpi.name} - câu ${posm.scheme} chưa chụp đủ hình theo yêu cầu 0/1.';
                  }
                }
                // else if(posm.value ==0)
                // {
                //   if (ExString(posm.comment.toString()).isNullOrWhiteSpace()) {
                //     return 'KPI ${kpi.name} - câu ${posm.scheme} cần ghi chú.';
                //   }
                // }
              }
            }
          }
        }
      }
    } else {
      return "";
    }
  }
}
