import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/context/photoContext.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/AttendantInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

class ShopController extends BaseController {
  RxList<MasterInfo> lstKPI = <MasterInfo>[].obs;
  RxList<AttendantInfo> lstAttendants = <AttendantInfo>[].obs;
  Rx<Position> position;
  String error = "";
  String documentPath;
  RxString imagePath = "".obs;
  final int checkin = 0;
  final int checkout = 1;
  ImagePicker picker = ImagePicker();
  RxString imageCheckInPath = "".obs;
  RxString imageCheckOutPath = "".obs;
  int showKPI = -1; // chưa chọn trạng thái cửa hàng
  RxString errorKPI = "".obs;
  //RxString ProcessTakePhoto = "Waiting".obs;
  RxList<String> ProcessTakePhoto = <String>[].obs;
  Rx<AttendantInfo> overview = new AttendantInfo().obs;
  List<MasterInfo> lstMaster = <MasterInfo>[];
  Rx<MasterInfo> masterInfo = new MasterInfo(
          "ReasonResult", "0", 0, "--Chọn--", "--Chọn--", null, null, -1)
      .obs;
  RxInt CheckPosition = 1.obs;
  bool isCapture = false;
  LoginInfo loginInfo;
  Location location = Location();
  TextEditingController controllerComment = new TextEditingController();
  FocusNode focusNodeComment = new FocusNode();
  Timer timeHandle;

  @override
  onInit() {
    //shop = Get.arguments[0];
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    //await createAuditResult(shop).then((value) => getShopOVVPath(shop));
    controllerComment.text = work.value.comment;
    await setPosition();
    super.onReady();
  }

  setPosition() async {
    // LocationData loc = await location.getLocation();
    // Position posTemp = new Position(
    //     longitude: loc.longitude,
    //     latitude: loc.latitude,
    //     accuracy: loc.accuracy,
    //     timestamp: null,
    //     altitude: null,
    //     speedAccuracy: null,
    //     heading: null,
    //     speed: null);
    // position = posTemp.obs;
    int timeStart = 0;
    while ((position == null ||
            position.value == null ||
            position.value.latitude == null ||
            position.value.longitude == null) &&
        timeStart < 15) {
      timeStart = timeStart + 1;
      LocationData loc = await location.getLocation();
      Position posTemp = new Position(
          longitude: loc.longitude,
          latitude: loc.latitude,
          accuracy: loc.accuracy,
          timestamp: null,
          altitude: null,
          speedAccuracy: null,
          heading: null,
          speed: null);
      position = posTemp.obs;
      if (position == null || position.value == null) {
        await Future.delayed(Duration(seconds: 1));
      }
    }

    print("start GPS CHECKIN/OUT: " +
        position.value.latitude.toString() +
        "," +
        position.value.longitude.toString());
  }

  Future<void> getShopOVVPath(ShopInfo shop) async {
    // documentPath = await FileUtils.getExternalStoragePath();
    // List<AttendantInfo> data = await PhotoContext.getPhotoByType(
    //     shopId: shop.shopId,
    //     type: 1000.toString(),
    //     workDate: DateTimes.today());
    // if (data != null && data.length > 0) {
    //   File file = new File(data[0].attendantPhoto);
    //   if (await file.exists()) {}
    //   imagePath.value = file.path;
    // } else {}

    loginInfo = await Shared.getUser();
    await PhotoContext.getOverView(shop.shopId, work.value.workDate)
        .then((value) => {
              overview.value = value,
              imagePath.value = overview.value.attendantPhoto,
            });
  }

  Future<void> getDataLayoutShopAudit(ShopInfo shop) async {
    await showProgess();
    await getAttendants(shop).then((String value) async {
      await hideProgess();
      if (!ExString(value).isNullOrWhiteSpace()) {
        alert(content: value);
      } else {
        await setSpinner(shop).then((value) async => await getKPIs(shop));
      }
    });
  }

  Future<String> getAttendants(ShopInfo shop) async {
    try {
      List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
          shopId: shop.shopId, workDate: DateTimes.today());
      error = "";
      if (data != null && data.length > 0) {
        if (data.length == 1) {
          if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
            imageCheckInPath.value = data[0].attendantPhoto;
          }
        }
        if (data.length == 2) {
          if (data[0].attendantType == 0 &&
              !ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
            imageCheckInPath.value = data[0].attendantPhoto;
          }
          if (data[1].attendantType == 1 &&
              !ExString(data[1].attendantPhoto).isNullOrWhiteSpace()) {
            imageCheckOutPath.value = data[1].attendantPhoto;
          }
        }
        lstAttendants.value = data;
        return error;
      } else {
        return error;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getKPIs(ShopInfo shop) async {
    try {
      if (lstKPI.length != 0) {
        lstKPI.clear();
      }
      List<MasterInfo> lstResult =
          await AuditContext.getMasterList("AUDITRESULT");
      if (lstResult == null || lstResult.length == 0) {
        return "Vui lòng kiểm tra danh sách 'AUDITRESULT'";
      }
      if (work.value.auditResult == null) {
        showKPI = -1;
      } else {
        if (lstResult != null && lstResult.length != 0) {
          for (MasterInfo shopStatus in lstResult) {
            if (work.value.auditResult == shopStatus.id &&
                shopStatus.refId == 1) {
              showKPI = 1; // trạng thái TC
              break;
            } else {
              showKPI = 0; // trạng thái KTC
            }
          }
        }
      }
      if (showKPI > 0) {
        await AuditContext.getKPIList(
                listCode: "KPI", work: work.value, shop: shop)
            .then((value) {
          lstKPI.value = value;
        });
      }

      return "";
    } catch (e) {
      return e.toString();
    }
  }

  toScreen(ShopInfo shop, MasterInfo kpi) async {
    List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
        shopId: shop.shopId, workDate: DateTimes.today());
    if (showKPI == -1) {
      alert(content: "Chưa chọn trạng thái cửa hàng.");
      return;
    }
    if (showKPI == 0) {
      alert(
          content:
              "Không thể khảo sát cửa hàng có trạng thái không thành công.");
      return;
    }
    bool ISOOS = false;
    List<MasterInfo> lstAns = await AuditContext.getMasterList('AUTOOOS');
    if (lstAns != null && lstAns.length > 0) {
      print(lstAns.first.code);
      ISOOS = true;
    }
    if (data != null && data.length > 0) {
      switch (kpi.id) {
        case 2:
          if(shop.shopType.endsWith("GT")) {
            Get.toNamed("\osa",
                arguments: <dynamic>[shop, work.value, kpi, ISOOS],
                preventDuplicates: false)
                .then((value) => getKPIs(shop));
          }
          else
            {
              Get.toNamed("\osamt",
                  arguments: <dynamic>[shop, work.value, kpi, ISOOS],
                  preventDuplicates: false)
                  .then((value) => getKPIs(shop));
            }
          break;
        case 3:
          Get.toNamed("\posm",
                  arguments: <dynamic>[shop, work.value, kpi],
                  preventDuplicates: false)
              .then((value) => getKPIs(shop));
          break;
        case 7:
          Get.toNamed("\promotion",
                  arguments: <dynamic>[shop, work.value, kpi],
                  preventDuplicates: false)
              .then((value) => getKPIs(shop));
          break;
        default:
          Get.toNamed("\survey",
                  arguments: <dynamic>[shop, work.value, kpi],
                  preventDuplicates: false)
              .then((value) => getKPIs(shop));
      }
    } else {
      alert(content: "Bạn chưa chụp hình chấm công.");
    }
  }

  checkInProcess(ShopInfo shop) async {
    ProcessTakePhoto.add("StartCheckIn");
    if (!work.value.locked) {
      await showProgess();
      await getShopOVVPath(shop);
      ProcessTakePhoto.add("GetshopoverviewDone");
      await hideProgess();
      if (imagePath.value != null &&
          !ExString(imagePath.value).isNullOrWhiteSpace()) {
        if (!isCapture &&
            ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
          startCamera(work.value, shop, checkin);
        }
      } else {
        alert(content: "Bạn chưa chụp overview cửa hàng.");
      }
    } else {
      alert(content: "Báo cáo đã khóa.");
    }
  }

  checkOutProcess(ShopInfo shop) async {
    int statusTC = -1;
    if (!work.value.locked) {
      if (!isCapture &&
          !ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
        if (work.value.auditResult != null && work.value.auditResult != 0) {
          List<MasterInfo> lstResult =
              await AuditContext.getMasterList("AUDITRESULT");
          if (lstResult == null || lstResult.length == 0) {
            alert(content: "Vui lòng kiểm tra danh sách 'AUDITRESULT'");
            return;
          }
          if (lstResult != null && lstResult.length != 0) {
            for (MasterInfo shopStatus in lstResult) {
              if (work.value.auditResult == shopStatus.id &&
                  shopStatus.refId == 1) {
                statusTC = 1; // trạng thái TC
                break;
              } else {
                statusTC = 0; // trạng thái KTC
              }
            }
          }
        } else {
          alert(content: "Bạn chưa chọn trạng thái cửa hàng.");
          return;
        }
        if (statusTC == 0 &&
            ExString(work.value.comment).isNullOrWhiteSpace()) {
          alert(content: "Bạn chưa nhập lý do.");
          return;
        }
        if (statusTC == 0) {
          List<MasterInfo> lstRuleApp =
              await AuditContext.getMasterListWithCode(
                  "RULEAPP", "CHECKRECORD");
          if (lstRuleApp != null &&
              lstRuleApp.length != 0 &&
              lstRuleApp[0].refCode.trim().isNotEmpty) {
            try {
              List<String> lstKpiCheck =
                  lstRuleApp[0].refCode.split(",").toList();
              if (lstKpiCheck != null && lstKpiCheck.length != 0) {
                for (String checkKPI in lstKpiCheck) {
                  if (int.parse(checkKPI) == work.value.auditResult) {
                    List<AudioInfo> lstRecord =
                        await AuditContext.getListAudio(work.value);
                    if (lstRecord == null || lstRecord.length == 0) {
                      alert(content: "Bạn chưa ghi âm lý do cửa hàng KTC.");
                      return;
                    }
                  }
                }
              }
            } catch (ex) {
              alert(content: ex.toString());
              return;
            }
          }
        }

        if (statusTC == 1) {
          errorKPI.value =
              await AuditContext.checkData(work: work.value, shop: shop);
          if (ExString(errorKPI.value).isNullOrWhiteSpace()) {
            startCamera(work.value, shop, checkout);
          } else {
            alert(content: errorKPI.value);
          }
        } else {
          startCamera(work.value, shop, checkout);
        }
      } else {
        alert(content: "Bạn chưa check in cửa hàng.");
      }
    } else {
      alert(content: "Báo cáo đã khóa.");
    }
  }

  Future<String> saveImage(WorkResultInfo work, ShopInfo shop, int type,
      File file, PickedFile pickedFile) async {
    error = "";
    // Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
    // if (gps.isMocked) {
    //   return 'Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập.';
    // }

    double _latitude = 0;
    double _longitude = 0;
    double _accuracy = 0;
    if (position != null &&
        position.value != null &&
        position.value.latitude > 0) {
      _latitude = position.value.latitude;
      _longitude = position.value.longitude;
      _accuracy = position.value.accuracy;
    }
    ProcessTakePhoto.add("Getlatitude" + _latitude.toString());

    int employeeId = await Shared.read<int>(key: "employeeId");
    loginInfo = await Shared.getUser();
    try {
      Uint8List data = await pickedFile.readAsBytes();
      if (file != null &&
          file.path != null &&
          data != null &&
          data.length > 0) {
        await Io.File(file.path).writeAsBytes(data);
      }
      File temp = new File(pickedFile.path);
      if (await temp.exists()) {
        temp.delete(recursive: true);
      }
      ProcessTakePhoto.add("Tempfile_fone" + file.length().toString());
      if (file != null && file.existsSync() && await file.length() > 0) {
        AttendantInfo photo = new AttendantInfo();
        if (Platform.isAndroid) {
          photo.attendantPhoto = file.path;
        } else {
          photo.attendantPhoto = file.path.split("/").last;
        }
        photo.workId = work.rowId;
        photo.shopId = shop.shopId;
        photo.attendantTime = DateTimes.now();
        photo.attendantType = type;
        photo.attendantDate = DateTimes.today();
        photo.uploaded = 0;
        photo.photoServer = loginInfo.employeeId.toString() +
            "_" +
            shop.shopId.toString() +
            "_ATT_" +
            type.toString() +
            "_" +
            photo.attendantTime.toString() +
            ".jpg";
        photo.latitude = _latitude; //position.value.latitude;
        photo.longitude = _longitude; //position.value.longitude;
        photo.accuracy = _accuracy; //position.value.accuracy;

        ProcessTakePhoto.add("InsertSQL");
        ProcessTakePhoto.add(photo.toJson().toString());

        await PhotoContext.insertOverView(photo);
        ProcessTakePhoto.add("InsertSQL_Done");
        List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
            shopId: shop.shopId, workDate: DateTimes.today());
        error = "";
        if (data != null && data.length > 0) {
          ProcessTakePhoto.add("AttPhoto:" + data.length.toString());
          ProcessTakePhoto.add("AttPhoto:" + jsonEncode(data));
          lstAttendants.clear();
          lstAttendants.addAll(data);
          if (data.length == 1) {
            if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
              imageCheckInPath.value = data[0].attendantPhoto;
              ProcessTakePhoto.add("CheckIN:" + data[0].attendantPhoto);
            }
          }
          if (data.length == 2) {
            if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
              imageCheckOutPath.value = data[0].attendantPhoto;
            }
            if (!ExString(data[1].attendantPhoto).isNullOrWhiteSpace()) {
              imageCheckOutPath.value = data[1].attendantPhoto;
            }
          }
        } else {
          error = "Vui lòng chụp lại hình chấm công.";
          ProcessTakePhoto.add("Vui lòng chụp lại hình chấm công.");
        }
        return error;
      } else {
        error = "Lưu hình không thành công vui lòng thử lại!";
        ProcessTakePhoto.add("Lưu hình không thành công vui lòng thử lại!");
        return error;
      }
    } catch (ex) {
      error = ex.toString();
      ProcessTakePhoto.add(ex.toString());
      return error;
    }
  }

  Future<void> saveOVV(File file, ShopInfo shop, PickedFile pickedFile) async {
    // Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
    // if (gps != null && gps.isMocked) {
    //   alert(content: 'Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập !');
    //   return ;
    // }
    if (file != null && file.path != null) {
      double _latitude = 0;
      double _longitude = 0;
      double _accuracy = 0;
      if (position != null &&
          position.value != null &&
          position.value.latitude > 0) {
        _latitude = position.value.latitude;
        _longitude = position.value.longitude;
        _accuracy = position.value.accuracy;
      }
      // if (position == null ||position.value== null ||  (position.value.latitude == 0 && position.value.longitude == 0))
      //   {
      //       await hideProgess();
      //       alert(content: 'Không lấy được tọa độ. Vui lòng thử lại !');
      //       return ;
      //   }

      await Io.File(file.path).writeAsBytes(await pickedFile.readAsBytes());
      File temp = new File(pickedFile.path);
      if (temp.existsSync()) {
        temp.deleteSync();
      }

      AttendantInfo att = new AttendantInfo();
      att.shopId = shop.shopId;
      att.attendantDate = DateTimes.today();
      att.attendantTime = DateTimes.now();
      att.uploaded = 0;
      att.workId = work.value.rowId;
      att.latitude = _latitude; // position.value.latitude;
      att.longitude = _longitude; //position.value.longitude;
      att.attendantType = 1000;
      att.accuracy = _accuracy; //position.value.accuracy;
      if (Platform.isAndroid) {
        att.attendantPhoto = file.path;
      } else {
        att.attendantPhoto = file.path.split("/").last;
      }
      att.photoServer = loginInfo.employeeId.toString() +
          "_" +
          shop.shopId.toString() +
          "_ATT_" +
          att.attendantType.toString() +
          "_" +
          att.attendantTime.toString() +
          ".jpg";
      await PhotoContext.insertOverView(att);
      await PhotoContext.getOverView(shop.shopId, work.value.workDate)
          .then((value) => {
                overview.value = value,
                imagePath.value = overview.value.attendantPhoto,
              });
      await hideProgess();
    } else {
      await hideProgess();
      alert(content: "Lưu ảnh không thành công vui lòng thử lại !");
      return;
    }
  }

  Future<WorkResultInfo> createAuditResult(ShopInfo shop) async {
    WorkResultInfo audit = new WorkResultInfo();
    audit.auditResult = null;
    audit.comment = null;
    audit.isDone = false;
    audit.isSave = false;
    audit.isUpload = false;
    audit.locked = false;
    audit.shopFormatId = 0;
    audit.shopId = shop.shopId;
    audit.shopType = shop.shopType;
    audit.workDate = DateTimes.today();
    audit.shopName = shop.shopName;
    audit.workTime = DateFormat('yyyy-MM-dd HH:mm:ss').format((DateTime.now()));
    await AuditContext.setAudit(audit).then((value) async => {
          audit = value,
        });
    if (audit != null) {
      work = audit.obs;
      return audit;
    } else {
      return null;
    }
  }

  Future<void> setAuditResult(WorkResultInfo work) async {
    if (work.auditResult == null ||
        (work.auditResult != null &&
            (work.auditResult == 0 || work.auditResult == 1))) {
      work.comment = null;
      controllerComment.clear();
    }
    await AuditContext.setAudit(work).then((value) => {
          for (MasterInfo item in lstMaster)
            {
              if (item.id == work.auditResult)
                {
                  masterInfo.value = item,
                }
            }
        });
  }

  Future<void> setComment(WorkResultInfo work) async {
    await AuditContext.setAudit(work)
        .then((value) => {this.work.value = value});
  }

  Future<WorkResultInfo> lockAuditResult(WorkResultInfo work) async {
    WorkResultInfo temp;
    await AuditContext.lockAudit(work).then((value) => {temp = value});
    return temp;
  }

  Future<WorkResultInfo> rollBackAuditResult(WorkResultInfo work) async {
    WorkResultInfo temp;
    await AuditContext.rollBackAudit(work).then((value) => {temp = value});
    return temp;
  }

  Future<void> setSpinner(ShopInfo shop) async {
    await AuditContext.getMasterList("AUDITRESULT")
        .then((List<MasterInfo> value) => {
              lstMaster = value,
              if (lstMaster != null && lstMaster.length != 0)
                {masterInfo.value = lstMaster.first, loadSpinner(work.value)}
              else
                {}
            });
  }

  loadSpinner(WorkResultInfo work) {
    if (work != null &&
        work.auditResult != null &&
        work.auditResult != 0 &&
        lstMaster != null &&
        lstMaster.length != 0) {
      for (MasterInfo item in lstMaster) {
        if (item.id == work.auditResult) {
          masterInfo = item.obs;
        }
      }
    } else if (lstMaster != null && lstMaster.length != 0) {
      masterInfo.value = lstMaster.first;
    } else {}
  }

  Future<void> startCamera(WorkResultInfo work, ShopInfo shop, int type) async {
    ProcessTakePhoto.add("StartCamera");
    isCapture = true;
    await showProgess(mesage: "Đang tải dữ liệu...");
    await setPosition();
    ProcessTakePhoto.add("GetPositionDone");
    await hideProgess();
    if (work.auditResult == 0) {
      confirmOK("Lỗi trạng thái cửa hàng. Vui lòng chọn lại.", () {
        backPressed();
      });
      return;
    }

    // if (position == null ||position.value== null ||  (position.value.latitude == 0 && position.value.longitude == 0)) {
    //   alert(content: "Không lấy được vị trí làm việc. Vui lòng thử lại.");
    //   return;
    // }

    // Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
    // if (gps.isMocked) {
    //   alert(content: "Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập.");
    //   return;
    // }

    if (work != null && !work.locked) {
      ProcessTakePhoto.add("PickedFileStart");
      try {
        // ignore: deprecated_member_use
        PickedFile pickedFile = await picker.getImage(
            source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
        if (pickedFile != null &&
            !ExString(pickedFile.path).isNullOrWhiteSpace()) {
          ProcessTakePhoto.add("PickedFile_OK" + pickedFile.path);
          isCapture = false;
          File file = await FileUtils.createImage();
          ProcessTakePhoto.add("SaveImage_start");
          await saveImage(work, shop, type, file, pickedFile)
              .then((String value) async {
            if (!ExString(value).isNullOrWhiteSpace()) {
              alert(content: value);
            } else {
              if (type == 1) {
                work.isDone = true;
                work.isSave = true;
                await lockAuditResult(work).then((WorkResultInfo value) async {
                  this.work.value = value;
                  if (!this.work.value.locked) {
                    alert(content: "Báo cáo chưa khóa vui lòng chụp lại.");
                    work.isDone = false;
                    work.isSave = false;
                    await rollBackAuditResult(work).then(
                        (WorkResultInfo value) => {this.work.value = value});
                  }
                });
              }
            }
          });
        } else {
          ProcessTakePhoto.add("pickedFile_emy");
          alert(content: "Không lưu được ảnh.");
          isCapture = false;
          if (type == checkin) {
            imageCheckInPath.value = "";
          }
          if (type == checkout) {
            imageCheckOutPath.value = "";
          }
        }
      } catch (error) {
        alert(content: error.toString());
        ProcessTakePhoto.add(error);
      }
    }
  }

  Future<bool> backPressed() async {
    Get.back();
    return false;
  }

  Future<void> selectedDropdownButtonHandler(
      ShopInfo shop, MasterInfo status) async {
    int workingStatus = 0;
    if (!work.value.locked) {
      if (!ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
        if (status.refId == 1) {
          work.value.auditResult = status.id;
          masterInfo.value = status;
          await setAuditResult(work.value).then((value) => getKPIs(shop));
        } else {
          if (lstKPI != null && lstKPI.length != 0) {
            for (MasterInfo kpi in lstKPI) {
              if (kpi.kpiStatus != 0) {
                workingStatus = 1;
                break;
              }
            }
            if (workingStatus == 1) {
              confirm(
                  content:
                      'Dữ liệu làm việc sẽ được xóa khi chọn trạng thái ${status.name}. Bạn có đồng ý ?',
                  onConfirm: () async {
                    navigator.pop();
                    await showProgess();
                    await AuditContext.deleteDataAudit(work.value)
                        .then((int value) async {
                      await hideProgess();
                      if (value == 0) {
                        work.value.auditResult = status.id;
                        masterInfo.value = status;
                        await setAuditResult(work.value)
                            .then((value) => lstKPI.clear());
                      } else {
                        alert(
                            content:
                                "Lỗi xóa dữ liệu chưa hoàn tất, vui lòng chọn lại trạng thái không thành công.");
                      }
                    });
                  });
            } else {
              work.value.auditResult = status.id;
              masterInfo.value = status;
              await setAuditResult(work.value).then((value) => lstKPI.clear());
            }
          } else {
            work.value.auditResult = status.id;
            masterInfo.value = status;
            lstKPI.clear();
          }
        }
      } else {
        alert(content: "Bạn chưa chụp checkin cửa hàng.");
      }
    } else {
      alert(content: "Báo cáo đã khóa");
    }
  }
}
