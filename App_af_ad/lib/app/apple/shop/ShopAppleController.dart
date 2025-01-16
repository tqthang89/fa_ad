import 'dart:async';
import 'dart:io';
import 'dart:io' as Io;

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/AttendantInfo.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

import '../../base_controller.dart';
import '../../core/HttpResponseMessage.dart';
import '../../core/HttpUtils.dart';
import '../../core/Urls.dart';

class AttendantAppleInfo {
  String linkin;
  String linkout;
  String address;

  AttendantAppleInfo();

  Map<String, dynamic> toMap() =>
      {"linkin": linkin, "linkout": linkout, "address": address};

  @override
  AttendantAppleInfo.fromMap(Map<String, dynamic> map) {
    linkin = map["linkin"];
    linkout = map["linkout"];
    address = map["address"];
  }

  AttendantAppleInfo.fromJson(dynamic json) {
    linkin = json["linkin"];
    linkout = json["linkout"];
    address = json["address"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    //map["RowId"] = rowId;
    map["linkin"] = linkin;
    map["linkout"] = linkout;
    map["address"] = address;
    return map;
  }
}

class ShopAppleController extends BaseController {
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
  Rx<AttendantInfo> overview = new AttendantInfo().obs;
  List<MasterInfo> lstMaster = <MasterInfo>[];
  Rx<MasterInfo> masterInfo = new MasterInfo(
      "ReasonResult", "0", 0, "--Choose--", "--Choose--", null, null, -1)
      .obs;
  bool isCapture = false;
  LoginInfo loginInfo;
  Location location = Location();
  TextEditingController controllerComment = new TextEditingController();
  FocusNode focusNodeComment = new FocusNode();
  Timer timeHandle;
  TextEditingController tx = new TextEditingController();
  ShopAppleController controller;
  TabController tabController;
  ShopInfo shop;
  List<String> lst;

  Axis scrollDirection = Axis.vertical;
  ScrollController scrollController;

  @override
  onInit() async {
    shop = Get.arguments[0];
    //controller.work = Get.arguments[1].obs;
    // lst = [];
    // lst.add('Information');
    // lst.add('Work');
    // tabController = new TabController(length: lst.length, vsync: this);
    // tabController.addListener(() {
    //   if (tabController.indexIsChanging) {
    //     FocusScope.of(Get.context).requestFocus(new FocusNode());
    //   }
    // });

    HttpResponseMessage response =
    HttpResponseMessage(statusCode: 202, content: "Start send...");

    Map<String, String> param = new Map();
    param["FUNCTION"] = "GET_PHOTO_APPLE";
    param["ShopId"] = shop.shopId.toString();
    response = await HttpUtils.post(body: param, url: Urls.UPLOAD_FILE);
    print(response.statusCode.toString() + '-' + response.content.toString());
    if (response.statusCode == 200) {
      if(response.content != null) {
        List<AttendantAppleInfo> ap =  (response.content as List)
            .map((i) => AttendantAppleInfo.fromJson(i))
            .toList(); //AttendantAppleInfo.fromJson(response.content);
        if(ap != null && ap.length > 0 && ap[0].linkin != "EMPTY") {
          if (!ExString(ap[0].linkin).isNullOrWhiteSpace())
            imageCheckInPath = ap[0].linkin.obs;
          if (!ExString(ap[0].linkout).isNullOrWhiteSpace())
            imageCheckOutPath = ap[0].linkout.obs;
          tx.text = ap[0].address;
        }
      }
      change(null, status: RxStatus.success());
    }

    isEnableGPS();
    super.onInit();
  }

  onBackPress() {
    Get.back();
  }

  bool onBack() {
    Get.back();
    return false;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Future<void> onReady() async {
    //await createAuditResult(shop).then((value) => getShopOVVPath(shop));
    work = new WorkResultInfo().obs; //demo
    controllerComment.text = work.value.comment;
    change(null, status: RxStatus.success());
    super.onReady();
  }

  Future<void> callWitiPhoneNumner(String phone) async {
    try {
      if (!phone.isNullOrWhiteSpace()) {
        await launch("tel://" + phone);
      }
    } catch (ex) {
      controller.alert(content: ex.toString());
    }
  }

  setPosition() async {
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
    change(null, status: RxStatus.success());
    print("start GPS CHECKIN/OUT: " +
        position.value.latitude.toString() +
        "," +
        position.value.longitude.toString() +
        "," +
        position.value.accuracy.toString());
  }

  Future<void> startCamera(int AttendanceType) async {
    try {
      if (position == null) {
        await setPosition();
      }
      HttpResponseMessage response =
      HttpResponseMessage(statusCode: 202, content: "Start send...");
      PickedFile pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 1280, imageQuality: 90);
      if (pickedFile != null && !pickedFile.path.isNullOrWhiteSpace()) {
        Map<String, String> param = new Map();
        print(shop.shopId.toString() + '/' + pickedFile.path);
        param["FUNCTION"] = "PHOTO_APPLE";
        param["ShopId"] = shop.shopId.toString();
        param["AttendanceType"] = AttendanceType.toString();
        param["Address"] = tx.text;
        param["latitude"] = position.value.latitude.toString();
        param["longitude"] = position.value.longitude.toString();
        File imageFile = File(pickedFile.path);
        response = await HttpUtils.uploadFile(
            body: param, file: imageFile, url: Urls.UPLOAD_FILE);
        print(response.statusCode.toString() + '-' + response.content.toString());
        if (response.statusCode == 200) {
          if (AttendanceType == 0) imageCheckInPath = response.content.toString().obs;
          if (AttendanceType == 1) imageCheckOutPath = response.content.toString().obs;
          change(null, status: RxStatus.success());
        }
        File temp = new File(pickedFile.path);
        if (await temp.exists()) {
          temp.delete(recursive: true);
        }
      }
    } catch (ex) {
      //await controller.hideProgess();
    }
  }

  // Future<void> getShopOVVPath(ShopInfo shop) async {
  //   // documentPath = await FileUtils.getExternalStoragePath();
  //   // List<AttendantInfo> data = await PhotoContext.getPhotoByType(
  //   //     shopId: shop.shopId,
  //   //     type: 1000.toString(),
  //   //     workDate: DateTimes.today());
  //   // if (data != null && data.length > 0) {
  //   //   File file = new File(data[0].attendantPhoto);
  //   //   if (await file.exists()) {}
  //   //   imagePath.value = file.path;
  //   // } else {}
  //
  //   loginInfo = await Shared.getUser();
  //   await PhotoContext.getOverView(shop.shopId, work.value.workDate)
  //       .then((value) => {
  //             overview.value = value,
  //             imagePath.value = overview.value.attendantPhoto,
  //           });
  // }
  //
  // Future<void> getDataLayoutShopAudit(ShopInfo shop) async {
  //   await showProgess();
  //   await getAttendants(shop).then((String value) async {
  //     await hideProgess();
  //     if (!ExString(value).isNullOrWhiteSpace()) {
  //       alert(content: value);
  //     } else {
  //       await setSpinner(shop).then((value) async => await getKPIs(shop));
  //     }
  //   });
  // }
  //
  // Future<String> getAttendants(ShopInfo shop) async {
  //   try {
  //     List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
  //         shopId: shop.shopId, workDate: DateTimes.today());
  //     error = "";
  //     if (data != null && data.length > 0) {
  //       if (data.length == 1) {
  //         if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
  //           imageCheckInPath.value = data[0].attendantPhoto;
  //         }
  //       }
  //       if (data.length == 2) {
  //         if (data[0].attendantType == 0 &&
  //             !ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
  //           imageCheckInPath.value = data[0].attendantPhoto;
  //         }
  //         if (data[1].attendantType == 1 &&
  //             !ExString(data[1].attendantPhoto).isNullOrWhiteSpace()) {
  //           imageCheckOutPath.value = data[1].attendantPhoto;
  //         }
  //       }
  //       lstAttendants.value = data;
  //       return error;
  //     } else {
  //       return error;
  //     }
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
  //
  // Future<String> getKPIs(ShopInfo shop) async {
  //   try {
  //     if (lstKPI.length != 0) {
  //       lstKPI.clear();
  //     }
  //     List<MasterInfo> lstResult =
  //         await AuditContext.getMasterList("AUDITRESULT");
  //     if (lstResult == null || lstResult.length == 0) {
  //       return "Vui lòng kiểm tra danh sách 'AUDITRESULT'";
  //     }
  //     if (work.value.auditResult == null) {
  //       showKPI = -1;
  //     } else {
  //       if (lstResult != null && lstResult.length != 0) {
  //         for (MasterInfo shopStatus in lstResult) {
  //           if (work.value.auditResult == shopStatus.id &&
  //               shopStatus.refId == 1) {
  //             showKPI = 1; // trạng thái TC
  //             break;
  //           } else {
  //             showKPI = 0; // trạng thái KTC
  //           }
  //         }
  //       }
  //     }
  //     if (showKPI > 0) {
  //       await AuditContext.getKPIList(
  //               listCode: "KPI", work: work.value, shop: shop)
  //           .then((value) {
  //         lstKPI.value = value;
  //       });
  //     }
  //
  //     return "";
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
  //
  // toScreen(ShopInfo shop, MasterInfo kpi) async {
  //   List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
  //       shopId: shop.shopId, workDate: DateTimes.today());
  //   if (showKPI == -1) {
  //     alert(content: "Chưa chọn trạng thái cửa hàng.");
  //     return;
  //   }
  //   if (showKPI == 0) {
  //     alert(
  //         content:
  //             "Không thể khảo sát cửa hàng có trạng thái không thành công.");
  //     return;
  //   }
  //   if (data != null && data.length > 0) {
  //     switch (kpi.id) {
  //       case 2:
  //         Get.toNamed("\osa",
  //                 arguments: <dynamic>[shop, work.value, kpi],
  //                 preventDuplicates: false)
  //             .then((value) => getKPIs(shop));
  //         break;
  //       case 3:
  //         Get.toNamed("\posm",
  //                 arguments: <dynamic>[shop, work.value, kpi],
  //                 preventDuplicates: false)
  //             .then((value) => getKPIs(shop));
  //         break;
  //       default:
  //         Get.toNamed("\survey",
  //                 arguments: <dynamic>[shop, work.value, kpi],
  //                 preventDuplicates: false)
  //             .then((value) => getKPIs(shop));
  //     }
  //   } else {
  //     alert(content: "Bạn chưa chụp hình chấm công.");
  //   }
  // }
  //
  // checkInProcess(ShopInfo shop) async {
  //   if (!work.value.locked) {
  //     await showProgess();
  //     await getShopOVVPath(shop);
  //     await hideProgess();
  //     if (imagePath.value != null &&
  //         !ExString(imagePath.value).isNullOrWhiteSpace()) {
  //       if (!isCapture &&
  //           ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
  //         startCamera(work.value, shop, checkin);
  //       }
  //     } else {
  //       alert(content: "Bạn chưa chụp overview cửa hàng.");
  //     }
  //   } else {
  //     alert(content: "Báo cáo đã khóa.");
  //   }
  // }
  //

  void alertApple({String title = 'Message', @required String content}) {
    Get.defaultDialog(
        title: title,
        titleStyle: TextStyle(color: Colors.black, fontSize: 18),
        middleText: content,
        middleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        radius: 10,
        barrierDismissible: false,
        buttonColor: Colors.white,
        textConfirm: 'Đóng',
        onConfirm: () {
          Get.back();
        },
        confirmTextColor: Colors.blue[500]);
  }

  checkOutProcess(int AttendanceType) async {
    isEnableGPS();
    if (tx.text == null || tx.text == "") {
      alertApple(content: 'Please enter your work address');
      return;
    }
    startCamera(AttendanceType);
  }

  // Future<String> saveImage(WorkResultInfo work, ShopInfo shop, int type,
  //     File file, PickedFile pickedFile) async {
  //   error = "";
  //   Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
  //   if (gps.isMocked) {
  //     return 'Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập.';
  //   }
  //
  //   int employeeId = await Shared.read<int>(key: "employeeId");
  //   loginInfo = await Shared.getUser();
  //   try {
  //     Uint8List data = await pickedFile.readAsBytes();
  //     if (file != null &&
  //         file.path != null &&
  //         data != null &&
  //         data.length > 0) {
  //       await Io.File(file.path).writeAsBytes(data);
  //     }
  //     File temp = new File(pickedFile.path);
  //     if (await temp.exists()) {
  //       temp.delete(recursive: true);
  //     }
  //     if (file != null && file.existsSync() && await file.length() > 0) {
  //       AttendantInfo photo = new AttendantInfo();
  //       if (Platform.isAndroid) {
  //         photo.attendantPhoto = file.path;
  //       } else {
  //         photo.attendantPhoto = file.path.split("/").last;
  //       }
  //       photo.workId = work.rowId;
  //       photo.shopId = shop.shopId;
  //       photo.attendantTime = DateTimes.now();
  //       photo.attendantType = type;
  //       photo.attendantDate = DateTimes.today();
  //       photo.uploaded = 0;
  //       photo.photoServer = loginInfo.employeeId.toString() +
  //           "_" +
  //           shop.shopId.toString() +
  //           "_ATT_" +
  //           type.toString() +
  //           "_" +
  //           photo.attendantTime.toString() +
  //           ".jpg";
  //       photo.latitude = position.value.latitude;
  //       photo.longitude = position.value.longitude;
  //       photo.accuracy = position.value.accuracy;
  //
  //       await PhotoContext.insertOverView(photo);
  //       List<AttendantInfo> data = await PhotoContext.getAttendantPhotos(
  //           shopId: shop.shopId, workDate: DateTimes.today());
  //       error = "";
  //       if (data != null && data.length > 0) {
  //         lstAttendants.clear();
  //         lstAttendants.addAll(data);
  //         if (data.length == 1) {
  //           if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
  //             imageCheckInPath.value = data[0].attendantPhoto;
  //           }
  //         }
  //         if (data.length == 2) {
  //           if (!ExString(data[0].attendantPhoto).isNullOrWhiteSpace()) {
  //             imageCheckOutPath.value = data[0].attendantPhoto;
  //           }
  //           if (!ExString(data[1].attendantPhoto).isNullOrWhiteSpace()) {
  //             imageCheckOutPath.value = data[1].attendantPhoto;
  //           }
  //         }
  //       } else {
  //         error = "Vui lòng chụp lại hình chấm công.";
  //       }
  //       return error;
  //     } else {
  //       error = "Lưu hình không thành công vui lòng thử lại!";
  //       return error;
  //     }
  //   } catch (ex) {
  //     error = ex.toString();
  //     return error;
  //   }
  // }
  //
  // Future<void> saveOVV(File file, ShopInfo shop, PickedFile pickedFile) async {
  //   Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
  //   if (gps.isMocked) {
  //     alert(content: 'Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập !');
  //     return ;
  //   }
  //   if (file != null && file.path != null) {
  //     await Io.File(file.path).writeAsBytes(await pickedFile.readAsBytes());
  //     File temp = new File(pickedFile.path);
  //     if (temp.existsSync()) {
  //       temp.deleteSync();
  //     }
  //
  //     AttendantInfo att = new AttendantInfo();
  //     att.shopId = shop.shopId;
  //     att.attendantDate = DateTimes.today();
  //     att.attendantTime = DateTimes.now();
  //     att.uploaded = 0;
  //     att.workId = work.value.rowId;
  //     att.latitude = position.value.latitude;
  //     att.longitude = position.value.longitude;
  //     att.attendantType = 1000;
  //     att.accuracy = position.value.accuracy;
  //     if (Platform.isAndroid) {
  //       att.attendantPhoto = file.path;
  //     } else {
  //       att.attendantPhoto = file.path.split("/").last;
  //     }
  //     att.photoServer = loginInfo.employeeId.toString() +
  //         "_" +
  //         shop.shopId.toString() +
  //         "_ATT_" +
  //         att.attendantType.toString() +
  //         "_" +
  //         att.attendantTime.toString() +
  //         ".jpg";
  //     await PhotoContext.insertOverView(att);
  //     await PhotoContext.getOverView(shop.shopId, work.value.workDate)
  //         .then((value) => {
  //               overview.value = value,
  //               imagePath.value = overview.value.attendantPhoto,
  //             });
  //     await hideProgess();
  //   } else {
  //     await hideProgess();
  //     alert(content: "Lưu ảnh không thành công vui lòng thử lại !");
  //     return;
  //   }
  // }
  //
  // Future<WorkResultInfo> createAuditResult(ShopInfo shop) async {
  //   WorkResultInfo audit = new WorkResultInfo();
  //   audit.auditResult = null;
  //   audit.comment = null;
  //   audit.isDone = false;
  //   audit.isSave = false;
  //   audit.isUpload = false;
  //   audit.locked = false;
  //   audit.shopFormatId = 0;
  //   audit.shopId = shop.shopId;
  //   audit.shopType = shop.shopType;
  //   audit.workDate = DateTimes.today();
  //   audit.shopName = shop.shopName;
  //   audit.workTime = DateFormat('yyyy-MM-dd HH:mm:ss').format((DateTime.now()));
  //   await AuditContext.setAudit(audit).then((value) async => {
  //         audit = value,
  //       });
  //   if (audit != null) {
  //     work = audit.obs;
  //     return audit;
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<void> setAuditResult(WorkResultInfo work) async {
  //   if (work.auditResult == null ||
  //       (work.auditResult != null &&
  //           (work.auditResult == 0 || work.auditResult == 1))) {
  //     work.comment = null;
  //     controllerComment.clear();
  //   }
  //   await AuditContext.setAudit(work).then((value) => {
  //         for (MasterInfo item in lstMaster)
  //           {
  //             if (item.id == work.auditResult)
  //               {
  //                 masterInfo.value = item,
  //               }
  //           }
  //       });
  // }
  //
  // Future<void> setComment(WorkResultInfo work) async {
  //   await AuditContext.setAudit(work)
  //       .then((value) => {this.work.value = value});
  // }
  //
  // Future<WorkResultInfo> lockAuditResult(WorkResultInfo work) async {
  //   WorkResultInfo temp;
  //   await AuditContext.lockAudit(work).then((value) => {temp = value});
  //   return temp;
  // }
  //
  // Future<WorkResultInfo> rollBackAuditResult(WorkResultInfo work) async {
  //   WorkResultInfo temp;
  //   await AuditContext.rollBackAudit(work).then((value) => {temp = value});
  //   return temp;
  // }
  //
  // Future<void> setSpinner(ShopInfo shop) async {
  //   await AuditContext.getMasterList("AUDITRESULT")
  //       .then((List<MasterInfo> value) => {
  //             lstMaster = value,
  //             if (lstMaster != null && lstMaster.length != 0)
  //               {masterInfo.value = lstMaster.first, loadSpinner(work.value)}
  //             else
  //               {}
  //           });
  // }
  //
  // loadSpinner(WorkResultInfo work) {
  //   if (work != null &&
  //       work.auditResult != null &&
  //       work.auditResult != 0 &&
  //       lstMaster != null &&
  //       lstMaster.length != 0) {
  //     for (MasterInfo item in lstMaster) {
  //       if (item.id == work.auditResult) {
  //         masterInfo = item.obs;
  //       }
  //     }
  //   } else if (lstMaster != null && lstMaster.length != 0) {
  //     masterInfo.value = lstMaster.first;
  //   } else {}
  // }
  //
  // Future<void> startCamera(WorkResultInfo work, ShopInfo shop, int type) async {
  //   isCapture = true;
  //   await showProgess(mesage: "Đang tải dữ liệu...");
  //   await setPosition();
  //   await hideProgess();
  //   if (work.auditResult == 0) {
  //     confirmOK("Lỗi trạng thái cửa hàng. Vui lòng chọn lại.", () {
  //       backPressed();
  //     });
  //     return;
  //   }
  //   if (position.value.latitude == 0 && position.value.longitude == 0) {
  //     alert(content: "Không lấy được vị trí làm việc. Vui lòng thử lại.");
  //     return;
  //   }
  //
  //   if (work != null && !work.locked) {
  //     // ignore: deprecated_member_use
  //     PickedFile pickedFile = await picker.getImage(
  //         source: ImageSource.camera, maxWidth: 1280, imageQuality: 90);
  //     if (pickedFile != null &&
  //         !ExString(pickedFile.path).isNullOrWhiteSpace()) {
  //       isCapture = false;
  //       File file = await FileUtils.createImage();
  //       await saveImage(work, shop, type, file, pickedFile)
  //           .then((String value) async {
  //         if (!ExString(value).isNullOrWhiteSpace()) {
  //           alert(content: value);
  //         } else {
  //           if (type == 1) {
  //             work.isDone = true;
  //             work.isSave = true;
  //             await lockAuditResult(work).then((WorkResultInfo value) async {
  //               this.work.value = value;
  //               if (!this.work.value.locked) {
  //                 alert(content: "Báo cáo chưa khóa vui lòng chụp lại.");
  //                 work.isDone = false;
  //                 work.isSave = false;
  //                 await rollBackAuditResult(work).then(
  //                     (WorkResultInfo value) => {this.work.value = value});
  //               }
  //             });
  //           }
  //         }
  //       });
  //     } else {
  //       isCapture = false;
  //       if (type == checkin) {
  //         imageCheckInPath.value = "";
  //       }
  //       if (type == checkout) {
  //         imageCheckOutPath.value = "";
  //       }
  //     }
  //   }
  // }

  Future<bool> backPressed() async {
    Get.back();
    return false;
  }

// Future<void> selectedDropdownButtonHandler(
//     ShopInfo shop, MasterInfo status) async {
//   int workingStatus = 0;
//   if (!work.value.locked) {
//     if (!ExString(imageCheckInPath.value).isNullOrWhiteSpace()) {
//       if (status.refId == 1) {
//         work.value.auditResult = status.id;
//         masterInfo.value = status;
//         await setAuditResult(work.value).then((value) => getKPIs(shop));
//       } else {
//         if (lstKPI != null && lstKPI.length != 0) {
//           for (MasterInfo kpi in lstKPI) {
//             if (kpi.kpiStatus != 0) {
//               workingStatus = 1;
//               break;
//             }
//           }
//           if (workingStatus == 1) {
//             confirm(
//                 content:
//                     'Dữ liệu làm việc sẽ được xóa khi chọn trạng thái ${status.name}. Bạn có đồng ý ?',
//                 onConfirm: () async {
//                   navigator.pop();
//                   await showProgess();
//                   await AuditContext.deleteDataAudit(work.value)
//                       .then((int value) async {
//                     await hideProgess();
//                     if (value == 0) {
//                       work.value.auditResult = status.id;
//                       masterInfo.value = status;
//                       await setAuditResult(work.value)
//                           .then((value) => lstKPI.clear());
//                     } else {
//                       alert(
//                           content:
//                               "Lỗi xóa dữ liệu chưa hoàn tất, vui lòng chọn lại trạng thái không thành công.");
//                     }
//                   });
//                 });
//           } else {
//             work.value.auditResult = status.id;
//             masterInfo.value = status;
//             await setAuditResult(work.value).then((value) => lstKPI.clear());
//           }
//         } else {
//           work.value.auditResult = status.id;
//           masterInfo.value = status;
//           lstKPI.clear();
//         }
//       }
//     } else {
//       alert(content: "Bạn chưa chụp checkin cửa hàng.");
//     }
//   } else {
//     alert(content: "Báo cáo đã khóa");
//   }
// }
}
