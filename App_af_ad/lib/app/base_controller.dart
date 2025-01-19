import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/core/Shared.dart';

import 'base/PhotoInfo.dart';
import 'context/auditContext.dart';
import 'context/photoContext.dart';
import 'base/ShopInfo.dart';
import 'core/HttpResponseMessage.dart';
import 'core/HttpUtils.dart';
import 'core/Urls.dart';
import 'core/Utility.dart';
import 'models/CreateShopModel.dart';
import 'models/WorkResultInfo.dart';

abstract class BaseController extends FullLifeCycleController with StateMixin {
  ProgressDialog progess;
  RxList<PhotoInfo> lstPhoto = <PhotoInfo>[].obs;
  Rx<WorkResultInfo> work;
  String DirectoryPath="";
  @override
  void onInit() async {
    Directory directory = await getApplicationDocumentsDirectory();
    DirectoryPath = directory.path;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void createProgress(String content) {
    if (progess == null) {
      progess = ProgressDialog(Get.context, isDismissible: false);
    }
    progess.style(
      message: content,
      progress: 0.0,
      maxProgress: 100.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressWidget: Container(
          padding: EdgeInsets.all(10.0), child: CircularProgressIndicator()),
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600),
    );
  }

  void alert({String title = 'Thông báo', @required String content}) {
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

  void errorInterner() {
    alert(
        title: "Thông báo Internet",
        content: "Kết nối của bạn không ổn định, vui lòng kiểm tra lại");
    return;
  }

  Future<void> isEnableGPS() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled == null || !isLocationServiceEnabled) {
      alert(
          title: "Thông báo GPS",
          content: "Vui lòng bật GPS trước khi chụp ảnh.");
      return;
    }
  }

  void confirm(
      {String title = 'Thông báo',
      @required String content,
      Function onConfirm,
      Function onCancel}) {
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
        textConfirm: 'Đồng ý',
        textCancel: 'Không',
        cancelTextColor: Colors.red[500],
        confirmTextColor: Colors.blue[500],
        onConfirm: onConfirm != null
            ? onConfirm
            : () {
                Get.back();
              },
        onCancel: onCancel);
  }

  Future<void> showConfirmDialog(
      BuildContext context,
      String title,
      String content,
      Function onConfirm,
      Function onCancel,
      ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onCancel(); // Xử lý khi nhấn nút Cancel
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Bỏ qua'),
            ),
            TextButton(
              onPressed: () {
                onConfirm(); // Xử lý khi nhấn nút Confirm
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }

  confirmOK(String content, Function functionOk) async {
    Get.defaultDialog(
      title: "Thông báo",
      titlePadding: EdgeInsets.only(top: 20),
      content: Padding(padding: EdgeInsets.all(10), child: Text(content)),
      textConfirm: "Ok",
      onConfirm: functionOk,
    );
  }

  Future<bool> showProgess({String mesage = 'Đang tải vui lòng đợi...'}) async {
    try {
      if (progess == null) {
        progess = new ProgressDialog(Get.context, isDismissible: false);
      }
      progess.style(
        message: mesage,
        progress: 0.0,
        maxProgress: 100.0,
        backgroundColor: Colors.white,
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressWidget: Container(
            padding: EdgeInsets.all(10.0), child: CircularProgressIndicator()),
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600),
      );
    } catch (ex) {
      ex.toString();
    }
    return await progess.show();
  }

  Future<bool> hideProgess() async {
    return await progess.hide();
  }

  Future<String> saveImageKPI(
      {WorkResultInfo work,
      ShopInfo shop,
      int itemId,
      int kpiId,
      File file,
      PickedFile pickedFile}) async {
    LoginInfo user = await Shared.getUser();
    int employeeId = user.employeeId;
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
      if (file != null && file.existsSync() && await file.length() > 0) {
        PhotoInfo photo = new PhotoInfo();
        if (Platform.isAndroid) {
          photo.photoPath = file.path;
        } else {
          photo.photoPath = file.path.split("/").last;
        }
        photo.workId = work.rowId;
        photo.shopId = shop.shopId;
        photo.photoTime = DateTimes.now();
        photo.itemId = itemId;
        photo.kpiId = kpiId;
        photo.workDate = DateTimes.today();
        photo.uploaded = 0;
        photo.photoServer = employeeId.toString() +
            "_" +
            shop.shopId.toString() +
            "_KPI_" +
            kpiId.toString() +
            "_" +
            photo.photoTime.toString() +
            ".jpg";

        await PhotoContext.insertPhotoKPI(photo);
        List<PhotoInfo> data = await PhotoContext.getPhotoKPIs(
            workId: work.rowId, itemId: itemId, kpiId: kpiId);
        if (data != null && data.length > 0) {
          lstPhoto.clear();
          lstPhoto.addAll(data);
          return "";
        } else {
          return "Vui lòng chụp lại hình chấm công.";
        }
      } else {
        return "Lưu hình không thành công vui lòng thử lại!";
      }
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<HttpResponseMessage> saveImageOnline(
      {File file, PickedFile pickedFile}) async {
    HttpResponseMessage response = HttpResponseMessage(statusCode: 202, content: "Start send...");
    LoginInfo user = await Shared.getUser();
    int employeeId = user.employeeId;
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
      if (file != null && file.existsSync() && await file.length() > 0) {
        Map<String, String> param = new Map();
        param["FUNCTION"] = "PHOTO_SHOP";
        //param["ShopId"] = photo.shopId.toString();
        param["ImageTime"] = new DateFormat("MM/dd/yyyy HH:mm:ss")
            .format(new DateTime.now());
        param["ImageName"] = file.path
            .split("/")
            .last;
        response = await HttpUtils.uploadFile(
            body: param, file: file, url: Urls.UPLOAD_FILE);
        if (response.statusCode == 200) {
          return HttpResponseMessage(statusCode: 200, content: response.content);
        } else {
          return HttpResponseMessage(statusCode: 500, content: "Vui lòng chụp lại hình chấm công.");
        }
      }else{
        return HttpResponseMessage(statusCode: 500, content: "Vui lòng chụp lại hình chấm công.");
      }
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: "Vui lòng chụp lại hình chấm công.");
    }
  }

  Future<void> onRecord(ShopInfo shop) async {
    Get.toNamed("/record",
        arguments: <dynamic>[shop,work.value], preventDuplicates: false);
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

  Future<HttpResponseMessage> uploadResultCreateShop(
      {CreateShopModel result}) async {
    HttpResponseMessage response = HttpResponseMessage(statusCode: 202, content: "Start send...");
    LoginInfo user = await Shared.getUser();
    int employeeId = user.employeeId;
    try {
      Map<String, String> param = new Map();
      param["FUNCTION"] = "CREATE_SHOP";
      param["merchantName"] = result.merchantName;
      param["phoneNumber"] = result.phoneNumber.toString();
      param["provinceId"] = result.provinceId.toString();
      param["districtId"] = result.districtId.toString();
      param["townId"] = result.townId.toString();
      param["addressline"] = result.addressline.toString();
      param["areaDisplay"] = result.areaDisplay.toString();
      param["itemDisplay"] = result.itemDisplay;
      param["typeDisplay"] = result.typeDisplay;
      param["revenue"] = result.revenue;
      param["latitude"] = result.latitude.toString();
      param["longitude"] = result.longitude.toString();
      param["photo"] = result.photo;

      print(json.encode(result));
      //return HttpResponseMessage(statusCode: 500, content: "Vui lòng kiểm tra lại kết nối Internet !");

      if (await Utility.isInternetConnected()) {
        response = await HttpUtils.post(
            body: param, url: Urls.UPLOAD);
        if (response.statusCode == 200) {
          return HttpResponseMessage(statusCode: 200, content: "");
        } else {
          return HttpResponseMessage(statusCode: 500, content: response.content);
        }
      }else{
        return HttpResponseMessage(statusCode: 500, content: "Vui lòng kiểm tra lại kết nối Internet !");
      }
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: ex.toString());
    }
  }
}
