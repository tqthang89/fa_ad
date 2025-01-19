import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:intl/intl.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/OsaResultInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/PosmResult.dart';
import 'package:syngentaaudit/app/base/PromotionResult.dart';
import 'package:syngentaaudit/app/base/SurveyDetailResultInfo.dart';
import 'package:syngentaaudit/app/base/SurveyResultInfo.dart';
import 'package:syngentaaudit/app/base/UploadInfo.dart';
import 'package:syngentaaudit/app/base/UploadedItemInfo.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/models/AttendantInfo.dart';

import '../../../base_controller.dart';

class UploadController extends BaseController {
  int currentIndex;
  List<UploadInfo> dataUpload;
  LoginInfo loginInfo;
  DatabaseHelper db = new DatabaseHelper();
  //List<String> fileKey;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> init() async {
    // fileKey = new List.empty(growable: true);
    // fileKey.add("Attendant");
    // fileKey.add("Photo");
    // fileKey.add("Audio");
    // fileKey.add("Osa");
    // fileKey.add("Posm");
    // fileKey.add("Promotion");
    // fileKey.add("SurveyResult");
    // fileKey.add("SurveyDetailResult");

    loginInfo = await Shared.getUser();
    try {
      dataUpload = await AuditContext.getUpload();
      if (dataUpload != null && dataUpload.length > 0) {
        String tmpDate = "";
        for (UploadInfo tt in dataUpload) {
          tt.totalPhoto = 0;
          tt.totalPhotoSuccess = 0;
          tt.totalAudio = 0;
          tt.totalAudioSuccess = 0;
          tt.itemDetail = new List.empty(growable: true);
          List<UploadedItemInfo> _list =
              await AuditContext.getUploadItem(tt.workId);
          if (_list != null && _list.length > 0) {
            tt.itemDetail.addAll(_list);
            for (UploadedItemInfo item in tt.itemDetail) {
              if (item.itemName.contains('Photos') ||
                  item.itemName.contains('Attendants')) {
                tt.totalPhoto = tt.totalPhoto + item.itemId;
              }
              if (item.itemName.contains('Audios')) {
                tt.totalAudio = tt.totalAudio + item.itemId;
              }
            }
          }
          if (tmpDate.contains(tt.workDate.toString() + ";")) {
            continue;
          } else {
            tt.groupBy = DateTimes.dateToString(datetime: tt.workDate);
            tmpDate += tt.workDate.toString() + ";";
          }
        }
      }
      change(null, status: RxStatus.success());
    } catch (ex) {
      change(null, status: RxStatus.success());
      alert(content: ex.toString());
      return;
    }
  }

  String getListKPI(List<UploadedItemInfo> ItemDetail) {
    String sDesc = "";
    int i = 1;
    if (ItemDetail != null && ItemDetail.length > 0) {
      ItemDetail.forEach((itt) {
        i++;
        if (itt.itemId > 0) {
          if (i != ItemDetail.length) {
            sDesc += itt.itemName + ",";
          } else {
            sDesc += itt.itemName;
          }
        }
      });
    }
    return sDesc;
  }

  Future<void> upload() async {
    if (dataUpload == null || (dataUpload != null && dataUpload.length == 0)) {
      alert(content: "Không có dữ liệu cân upload !");
      return;
    }
    print('-----------1. Start upload');
    if (await Utility.isInternetConnected()) {
      HttpResponseMessage response =
          HttpResponseMessage(statusCode: 202, content: "Start send...");
      if (dataUpload != null && dataUpload.length > 0) {
        print('-----------dataUpload:' + dataUpload.length.toString());
        try {
          await showProgess();
          for (UploadInfo item in dataUpload) {
            //List<List<int>> arrayData = new List.empty(growable: true);
            print('-----------1.00: startupload shopid:' + item.shopId.toString());
            Map<String, List<int>> arrayData_new = new Map<String, List<int>>();

            Map<String, String> body = new Map();
            body["FUNCTION"] = "WORK_DATA";
            body["ShopId"] = item.shopId.toString();
            body["WorkTime"] = item.workTime;
            body["WorkDate"] = item.workDate.toString();
            body["ShopFormatId"] = item.shopFormatId.toString();
            body["AuditResult"] = item.auditResult.toString();
            body["ShopType"] = item.shopType.toString();
            body["Comment"] = item.comment;
            // upload attendant
            List<dynamic> arrayAttendant = new List.empty(growable: true);
            List<AttendantInfo> listAttendant =
                await AuditContext.getAttendantUpload(item.workId);
            if (listAttendant != null && listAttendant.length > 0) {
              for (AttendantInfo attendant in listAttendant) {
                // File file = new File(FileUtils.GetFilePath(
                //     DirectoryPath,
                //     attendant.attendantPhoto,
                //     attendant.attendantDate.toString()));
                // if (file != null &&
                //     file.existsSync() &&
                //     file.lengthSync() > 0) {
                var map = <String, dynamic>{};
                map["ShopId"] = attendant.shopId;
                map["ImageName"] = attendant.attendantPhoto
                    .split("/")
                    .last; // file.path.split("/").last;
                map["AttendantDate"] = attendant.attendantDate;
                map["AttendantType"] = attendant.attendantType;
                map["AttendantTime"] = new DateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(new DateTime.fromMillisecondsSinceEpoch(
                        attendant.attendantTime));
                map["Latitude"] = attendant.latitude;
                map["Longitude"] = attendant.longitude;
                map["Accuracy"] = attendant.accuracy;
                map["Accuracy"] = attendant.accuracy;
                map["AttendantServer"] = attendant.getUrl(loginInfo.employeeId);
                arrayAttendant.add(jsonEncode(map));
                //}
              }
            }
            //arrayData.add(utf8.encode(arrayAttendant.toString()));
            arrayData_new
                .addAll({"Attendant": utf8.encode(arrayAttendant.toString())});
            // upload photo
            List<dynamic> arrayPhoto = new List.empty(growable: true);
            List<PhotoInfo> listPhoto =
                await AuditContext.getPhotoUpload(item.workId);
            if (listPhoto != null && listPhoto.length > 0) {
              for (PhotoInfo photo in listPhoto) {
                //File file = new File(FileUtils.GetFilePath(
                //    DirectoryPath, photo.photoPath, item.workDate.toString()));
                // if (file != null &&
                //     file.existsSync() &&
                //     file.lengthSync() > 0) {
                var map = <String, dynamic>{};
                map["ShopId"] = photo.shopId;
                map["PhotoName"] = photo.photoPath
                    .split("/")
                    .last; // file.path.split("/").last;
                map["PhotoType"] = photo.photoType;
                map["PhotoTime"] = new DateFormat("yyyy-MM-dd HH:mm:ss").format(
                    new DateTime.fromMillisecondsSinceEpoch(photo.photoTime));
                map["KpiId"] = photo.kpiId;
                map["ItemId"] = photo.itemId;
                map["WorkDate"] = photo.workDate;
                map["PhotoServer"] = photo.getUrl(loginInfo.employeeId);
                arrayPhoto.add(jsonEncode(map));
                //}
              }
            }
            //arrayData.add(utf8.encode(arrayPhoto.toString()));
            arrayData_new.addAll({"Photo": utf8.encode(arrayPhoto.toString())});
            // upload audio
            List<dynamic> arrayAudio = new List.empty(growable: true);
            List<AudioInfo> listAudio =
                await AuditContext.getAudioUpload(item.workId);
            if (listAudio != null && listAudio.length > 0) {
              for (AudioInfo audio in listAudio) {
                //File file = new File(FileUtils.GetFilePathAudio(
                //    DirectoryPath, audio.audioLocal, item.workDate.toString()));
                //if (file != null &&
                //    file.existsSync() &&
                //    file.lengthSync() > 0) {
                var map = <String, dynamic>{};
                map["AudioName"] = audio.audioLocal
                    .split("/")
                    .last; // file.path.split("/").last;
                map["AudioServer"] = audio.getUrl(loginInfo.employeeId);
                arrayAudio.add(jsonEncode(map));
                //}
              }
            }
            //arrayData.add(utf8.encode(arrayAudio.toString()));
            arrayData_new.addAll({"Audio": utf8.encode(arrayAudio.toString())});
            // upload osa
            List<dynamic> arrayOSa = new List.empty(growable: true);
            List<OsaResultInfo> listOsa =
                await AuditContext.getOsaUpload(item.workId);
            if (listOsa != null && listOsa.length > 0) {
              for (OsaResultInfo osa in listOsa) {
                var map = <String, dynamic>{};
                map["ProductId"] = osa.productId;
                map["OsaValue"] = osa.osaValue;
                map["LayerValue"] = osa.layerValue;
                map["FootValue"] = osa.footValue;
                map["Comment"] = osa.comment;
                arrayOSa.add(jsonEncode(map));
              }
            }
            //arrayData.add(utf8.encode(arrayOSa.toString()));
            arrayData_new.addAll({"Osa": utf8.encode(arrayOSa.toString())});
            // upload posm
            List<dynamic> arrayPosm = new List.empty(growable: true);
            List<PosmResultInfo> lisPosm =
                await AuditContext.getPosmUpload(item.workId);
            if (lisPosm != null && lisPosm.length > 0) {
              for (PosmResultInfo posm in lisPosm) {
                var map = <String, dynamic>{};
                map["PosmId"] = posm.posmId;
                map["Target"] = posm.target;
                map["Comment"] = posm.comment;
                map["Value"] = posm.value;
                map["Status"] = posm.status;
                map["Quantity"] = posm.quantity;
                arrayPosm.add(jsonEncode(map));
              }
            }
            //arrayData.add(utf8.encode(arrayPosm.toString()));
            arrayData_new.addAll({"Posm": utf8.encode(arrayPosm.toString())});
            // upload promotion
            List<dynamic> arrayPromotion = new List.empty(growable: true);
            List<PromotionResultInfo> lisPromotion =
                await AuditContext.getPromotionUpload(item.workId);

            if (lisPromotion != null && lisPromotion.length > 0) {
              for (PromotionResultInfo posm in lisPromotion) {
                var map = <String, dynamic>{};
                print("PromotionId:" + posm.promotionId.toString());
                map["PromotionId"] = posm.promotionId;
                map["Comment"] = posm.comment;
                map["Value"] = posm.value;
                map["Value1"] = posm.value1;
                arrayPromotion.add(jsonEncode(map));
              }
            }
            //arrayData.add(utf8.encode(arrayPromotion.toString()));
            arrayData_new
                .addAll({"Promotion": utf8.encode(arrayPromotion.toString())});

            // upload survey result
            List<dynamic> arraySurveyResult = new List.empty(growable: true);
            List<SurveyResultInfo> lisSurveyResult =
                await AuditContext.getSurveyResultUpload(item.workId);
            if (lisSurveyResult != null && lisSurveyResult.length > 0) {
              for (SurveyResultInfo surveyResult in lisSurveyResult) {
                var map = <String, dynamic>{};
                map["SurveyId"] = surveyResult.surveyId;
                map["Value"] = surveyResult.value;
                map["Comment"] = surveyResult.comment;
                map["TextValue"] = surveyResult.textValue;
                arraySurveyResult.add(jsonEncode(map));
              }
            }
            //arrayData.add(utf8.encode(arraySurveyResult.toString()));
            arrayData_new.addAll(
                {"SurveyResult": utf8.encode(arraySurveyResult.toString())});
            // upload survey result detail
            List<dynamic> arraySurveyDetailResult =
                new List.empty(growable: true);
            List<SurveyDetailResultInfo> lisSurveyDetailResult =
                await AuditContext.getSurveyDetailResultInfoUpload(item.workId);
            if (lisSurveyDetailResult != null &&
                lisSurveyDetailResult.length > 0) {
              for (SurveyDetailResultInfo surveyDetailResult
                  in lisSurveyDetailResult) {
                var map = <String, dynamic>{};
                map["SurveyId"] = surveyDetailResult.surveyId;
                map["SdId"] = surveyDetailResult.sdId;
                map["Value"] = surveyDetailResult.value;
                arraySurveyDetailResult.add(jsonEncode(map));
              }
            }
            //arrayData.add(utf8.encode(arraySurveyDetailResult.toString()));
            arrayData_new.addAll({
              "SurveyDetailResult":
                  utf8.encode(arraySurveyDetailResult.toString())
            });

            // response = await HttpUtils.uploadBytes(
            //     url: Urls.UPLOAD,
            //     body: body,
            //     data: arrayData,
            //     fileKeys: fileKey);
            print(json.encode(body));
            print(json.encode(arrayData_new));
            response = await HttpUtils.uploadBytesV2(
                url: Urls.UPLOAD, body: body, data: arrayData_new);
            // upload file
            if (response.statusCode == 200) {
              if (listAttendant != null && listAttendant.length > 0) {
                for (AttendantInfo att in listAttendant) {
                  File file = new File(FileUtils.GetFilePath(DirectoryPath,
                      att.attendantPhoto, att.attendantDate.toString()));
                  if (file != null &&
                      file.existsSync() &&
                      file.lengthSync() > 0) {
                    Map<String, String> param = new Map();
                    param["FUNCTION"] = "ATTENDANT";
                    param["ShopId"] = att.shopId.toString();
                    param["ImageTime"] = new DateFormat("MM/dd/yyyy HH:mm:ss")
                        .format(new DateTime.fromMillisecondsSinceEpoch(
                            att.attendantTime));
                    param["ImageName"] = file.path.split("/").last;
                    response = await HttpUtils.uploadFile(
                        body: param, file: file, url: Urls.UPLOAD_FILE);
                    if (response.statusCode == 200) {
                      att.uploaded = 1;
                      db.updateTableHasrowId(TableNames.attendant, att);
                      item.totalPhotoSuccess = item.totalPhotoSuccess + 1;
                      change(null, status: RxStatus.success());
                    }
                  } else {
                    att.uploaded = 1;
                    db.updateTableHasrowId(TableNames.attendant, att);
                    item.totalPhotoSuccess = item.totalPhotoSuccess + 1;
                    change(null, status: RxStatus.success());
                  }
                }
              }
              if (listPhoto != null && listPhoto.length > 0) {
                for (PhotoInfo photo in listPhoto) {
                  File file = new File(FileUtils.GetFilePath(DirectoryPath,
                      photo.photoPath, item.workDate.toString()));
                  if (file != null &&
                      file.existsSync() &&
                      file.lengthSync() > 0) {
                    Map<String, String> param = new Map();
                    param["FUNCTION"] = "PHOTO";
                    param["ShopId"] = photo.shopId.toString();
                    param["ImageTime"] = new DateFormat("MM/dd/yyyy HH:mm:ss")
                        .format(new DateTime.fromMillisecondsSinceEpoch(
                            photo.photoTime));
                    param["ImageName"] = file.path.split("/").last;
                    response = await HttpUtils.uploadFile(
                        body: param, file: file, url: Urls.UPLOAD_FILE);
                    if (response.statusCode == 200) {
                      photo.uploaded = 1;
                      db.updateTableHasrowId(TableNames.photo, photo);
                      item.totalPhotoSuccess = item.totalPhotoSuccess + 1;
                      change(null, status: RxStatus.success());
                    }
                  } else {
                    photo.uploaded = 1;
                    db.updateTableHasrowId(TableNames.photo, photo);
                    item.totalPhotoSuccess = item.totalPhotoSuccess + 1;
                    change(null, status: RxStatus.success());
                  }
                }
              }
              if (listAudio != null && listAudio.length > 0) {
                for (AudioInfo audio in listAudio) {
                  File file = new File(FileUtils.GetFilePathAudio(DirectoryPath,
                      audio.audioLocal, item.workDate.toString()));
                  if (file != null &&
                      file.existsSync() &&
                      file.lengthSync() > 0) {
                    Map<String, String> param = new Map();
                    param["FUNCTION"] = "AUDIO";
                    param["AudioName"] = file.path.split("/").last;
                    response = await HttpUtils.uploadFile(
                        body: param, file: file, url: Urls.UPLOAD_FILE);
                    if (response.statusCode == 200) {
                      audio.uploaded = 1;
                      db.updateTableHasrowId(TableNames.audio, audio);
                      item.totalAudioSuccess = item.totalAudioSuccess + 1;
                      change(null, status: RxStatus.success());
                    }
                  } else {
                    audio.uploaded = 1;
                    db.updateTableHasrowId(TableNames.audio, audio);
                    item.totalAudioSuccess = item.totalAudioSuccess + 1;
                    change(null, status: RxStatus.success());
                  }
                }
              }

              listAttendant =
                  await AuditContext.getAttendantUpload(item.workId);
              listPhoto = await AuditContext.getPhotoUpload(item.workId);
              listAudio = await AuditContext.getAudioUpload(item.workId);

              if ((listAttendant == null ||
                      (listAttendant != null && listAttendant.length == 0)) &&
                  (listPhoto == null ||
                      (listPhoto != null && listPhoto.length == 0)) &&
                  (listAudio == null ||
                      (listAudio != null && listAudio.length == 0))) {
                await AuditContext.updateWorkResultDone(item.workId);
              }
            } else {
              alert( content: "Lỗi 1:" +  response.content.toString());
              return;
            }
          }
          await hideProgess();
          await init();
        } catch (ex) {
          await hideProgess();
          alert(content: "Lỗi:" +  ex.toString());
          return;
        }
      }
    } else {
      alert(content: "Vui lòng kiểm tra lại kết nối Internet !");
      return;
    }
  }
}
