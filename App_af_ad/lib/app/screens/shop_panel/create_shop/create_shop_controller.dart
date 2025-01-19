import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:syngentaaudit/app/base/AreaInfo.dart';
import 'package:syngentaaudit/app/base/DistrictInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/ProvinceInfo.dart';
import 'package:syngentaaudit/app/base/TownInfo.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/base/CreateShopInfo.dart';
import 'package:syngentaaudit/app/models/CreateShopModel.dart';

import '../../../base_controller.dart';

class CreateShopController extends BaseController {
  RxList<CreateShopInfo> lstField = <CreateShopInfo>[].obs;
  RxList<ProvinceInfo> lstProvince = <ProvinceInfo>[].obs;
  RxList<DistrictInfo> lstDistrict = <DistrictInfo>[].obs;
  RxList<TownInfo> lstTown = <TownInfo>[].obs;
  RxList<DistrictInfo> lstDistrictByProvince = <DistrictInfo>[].obs;
  List<PhotoInfo> lstP = <PhotoInfo>[];
  RxList<AreaInfo> lstArea = <AreaInfo>[].obs;
  CreateShopModel result = new CreateShopModel();
  bool isCapture = true;
  ImagePicker picker = ImagePicker();
  Rx<ProvinceInfo> selectProvince = (new ProvinceInfo()).obs;
      //(new ProvinceInfo(provinceId: 1, provinceName: "HANOI")).obs;
  Rx<DistrictInfo> selectDistrict = (new DistrictInfo()).obs;
  Rx<AreaInfo> selectArea = (new AreaInfo()).obs;
  Rx<TownInfo> selectTown = (new TownInfo()).obs;

  Rx<Position> position;
  Location location = Location();

  RxInt CountImage ;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() async {
    await setPosition();
    super.onReady();
  }
  setPosition() async {
    LocationData loc = await location.getLocation();
    Position posTemp = new Position(longitude: loc.longitude, latitude: loc.latitude,accuracy:  loc.accuracy, timestamp: null, altitude: null, speedAccuracy: null, heading: null, speed: null);
    position = posTemp.obs;
    print("start GPS CHECKIN/OUT: " +
        position.value.latitude.toString() +
        "," +
        position.value.longitude.toString());
  }

  Future<String> downloadProvince() async {
    HttpResponseMessage response = new HttpResponseMessage();
    if (await Utility.isInternetConnected()) {
      Map<String, String> params = new Map();
      params["FUNCTION"] = "PROVINCE";
      response = await HttpUtils.post(url: Urls.DOWNLOAD, body: params);
      if (response.statusCode == 200) {
        try {
          lstProvince = ((response.content as List)
                  .map((e) => ProvinceInfo.fromJson(e))
                  .toList())
              .obs;
          if (lstProvince != null && lstProvince.length != 0) {
            selectProvince = lstProvince.elementAt(0).obs;
            insertData(
                index: 2, type: "SP", svalue: selectProvince.value.provinceId);
          }
          return "";
        } catch (ex) {
          return ex.toString();
        }
      } else {
        return response.content.toString();
      }
    } else {
      return "Vui lòng kiểm tra lại mạng.";
    }
  }

  Future<String> downloadDistrict() async {
    HttpResponseMessage response = new HttpResponseMessage();
    if (await Utility.isInternetConnected()) {
      Map<String, String> params = new Map();
      params["FUNCTION"] = "DISTRICT";
      response = await HttpUtils.post(url: Urls.DOWNLOAD, body: params);
      if (response.statusCode == 200) {
        try {
          lstDistrict = ((response.content as List)
                  .map((e) => DistrictInfo.fromJson(e))
                  .toList())
              .obs;
          if (lstProvince != null && lstProvince.length != 0) {
            if (lstDistrict != null && lstDistrict.length != 0) {
              lstDistrictByProvince = (lstDistrict
                      .where((district) =>
                          selectProvince.value.provinceId ==
                          district.provinceId)
                      .toList())
                  .obs;
              selectDistrict = lstDistrictByProvince.elementAt(0).obs;
              insertData(
                  index: 3, type: "SD", svalue: selectDistrict.value.districtId);
              loadTown(selectDistrict.value);
            }
          }
          return "";
        } catch (ex) {
          return ex.toString();
        }
      } else {
        return response.content.toString();
      }
    } else {
      return "Vui lòng kiểm tra lại mạng.";
    }
  }

  Future<void> initData() async {
    try {
      //demo
      String jsonDemo =
          "[{\"group\":\"Thông tin cửa hàng\",\"title\":\"1.Tên chủ CH (*)\",\"type\":\"T\",\"img\":\"0\"}"
          ",{\"group\":\"Thông tin cửa hàng\",\"title\":\"2.Số điện thoại\",\"type\":\"T\",\"img\":\"0\"}"
          ",{\"group\":\"Thông tin cửa hàng\",\"title\":\"3.Tỉnh/Thành phố\",\"type\":\"SP\",\"img\":\"0\"}"
           ",{\"group\":\"Thông tin cửa hàng\",\"title\":\"4.Quận/Huyện\",\"type\":\"SD\",\"img\":\"0\"}"
          //
           ",{\"group\":\"Thông tin cửa hàng\",\"title\":\"5.Phường/Xã\",\"type\":\"ST\",\"img\":\"0\"}"
          ",{\"group\":\"Thông tin cửa hàng\",\"title\":\"6.Địa chỉ chi tiết\",\"type\":\"T\",\"img\":\"0\"}"
          //",{\"group\":\"Thông tin xe\",\"title\":\"3.Biển số xe (*)\",\"type\":\"T\",\"img\":\"0\"}"

          ",{\"group\":\"Trưng bày\",\"title\":\"7.Diện tích trưng bày\",\"type\":\"SA\",\"img\":\"0\"}"
          ",{\"group\":\"Trưng bày\",\"title\":\"8.Mặt hàng trưng bày\",\"type\":\"T\",\"img\":\"0\"}"
          ",{\"group\":\"Trưng bày\",\"title\":\"9.Đăng ký CT trưng bày\",\"type\":\"T\",\"img\":\"0\"}"
          ",{\"group\":\"Doanh thu\",\"title\":\"10.Doanh số ( triệu)\",\"type\":\"T\",\"img\":\"0\"}]";
          ",{\"group\":\"Hình ảnh\",\"title\":\"11.Hình ảnh\",\"type\":\"T\",\"img\":\"2\"}]";

      var json = jsonDecode(jsonDemo);
      List<CreateShopInfo> lstTemp =
      (json as List).map((e) => CreateShopInfo.fromJson(e)).toList();
      if (lstTemp != null && lstTemp.length != 0) {
        String group = "";
        for (CreateShopInfo item in lstTemp) {
          if (!ExString(item.group).isNullOrWhiteSpace() &&
              item.group != group) {
            group = item.group;
          } else {
            item.group = "";
          }
          lstField.add(item);
        }
        CountImage = 0.obs;
      }

      await downloadProvince().then((value) async {
        if (!ExString(value).isNullOrWhiteSpace()) {
          alert(content: value);
        } else {
          await downloadDistrict().then((value) async {
            if (!ExString(value).isNullOrWhiteSpace()) {
              alert(content: value);
            }
          });
        }
      });

      // //demo
      String jsonArea =
          "[\n{\"areaId\":5,\"areaName\":\"5m\"},{\"areaId\":10,\"areaName\":\"10m\"}\n]";
      var jsona = jsonDecode(jsonArea);
      lstArea = ((jsona as List).map((e) => AreaInfo.fromJson(e)).toList()).obs;
      if (lstArea != null && lstArea.length != 0) {
        selectArea = lstArea.elementAt(0).obs;
      }
      result.areaDisplay = 5;
      change(null, status: RxStatus.success());
    } catch (ex) {
      change(null, status: RxStatus.error(ex.toString()));
    }
  }

  Future<void> loadDistrict(ProvinceInfo value) async {
    selectProvince.value = value;
    if (lstProvince != null && lstProvince.length != 0) {
      if (lstDistrict != null && lstDistrict.length != 0) {
        lstDistrictByProvince = (lstDistrict
                .where((district) =>
                    selectProvince.value.provinceId == district.provinceId)
                .toList())
            .obs;
        selectDistrict = lstDistrictByProvince.elementAt(0).obs;
        loadTown(selectDistrict.value);
      }
    }
    change(null, status: RxStatus.success());
  }
  Future<void> loadTown(DistrictInfo value) async {
    selectDistrict.value = value;
    HttpResponseMessage response = new HttpResponseMessage();
    if (await Utility.isInternetConnected()) {
      Map<String, String> params = new Map();
      params["FUNCTION"] = "TOWN";
      params["districtid"] = value.districtId.toString();
      response = await HttpUtils.post(url: Urls.DOWNLOAD, body: params);
      if (response.statusCode == 200) {
        try {
          lstTown = ((response.content as List)
              .map((e) => TownInfo.fromJson(e))
              .toList())
              .obs;
          selectTown = lstTown.elementAt(0).obs;
          insertData(
              index: 4, type: "ST", svalue: selectTown.value.townId);
        } catch (ex) {
          alert(content: ex.toString()) ;
        }
      } else {
        alert(content:response.content.toString());
      }
    } else {
      alert(content: "Vui lòng kiểm tra lại mạng.");
    }
    change(null, status: RxStatus.success());
  }

  Future<bool> onBack() async {
    Get.back();
    return false;
  }

  Future<void> startCamera() async {
    bool check = await Utility.iosGPSEnable();
    if(check == false) {alert(content: "Vui lòng bật GPS"); return;}
    await showProgess();
    if (isCapture) {
      isCapture = false;
      // ignore: deprecated_member_use
      PickedFile pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 1280, imageQuality: 90);
      if (pickedFile != null &&
          !ExString(pickedFile.path).isNullOrWhiteSpace()) {
        File file = await FileUtils.createImage();
        await saveImageOnline(file: file, pickedFile: pickedFile)
            .then((HttpResponseMessage value) async {
          if (value.statusCode == 200) {
            CountImage = CountImage + 1;
            result.photo = value.content;
            result.latitude = position.value.latitude;
            result.longitude = position.value.longitude;
            lstP.add(new PhotoInfo(photoPath: result.photo,photoServer: value.content));
            isCapture = true;
            await hideProgess();
            change(null, status: RxStatus.success());
          } else {
            isCapture = true;
            await hideProgess();
            alert(content: value.content);
          }
        });
      } else {
        isCapture = true;
        await hideProgess();
        //alert(content: "Lỗi hình vui lòng chụp lại.");
      }
    } else {
      await hideProgess();
    }
  }

  Future<void> insertDistrict(DistrictInfo item) async {
    selectDistrict.value = item;
    change(null, status: RxStatus.success());
  }
  Future<void> insertTown(TownInfo item) async {
    selectTown.value = item;
    change(null, status: RxStatus.success());
  }

  Future<void> insertAreaDisplay(AreaInfo item) async {
    selectArea.value = item;
    change(null, status: RxStatus.success());
  }

  Future<void> insertData(
      {int index, String type, String value, int nvalue, int svalue}) async {
    if (type == "T") {
      if (index == 1) {
        result.phoneController = TextEditingController();
        result.phoneController.text = value.toString();
        result.phoneNumber = value;
      }
      else if (index == 0) {
        result.merchantNameController = TextEditingController();
        result.merchantNameController.text = value;
        result.merchantName = value;
      }
      else if (index == 5) {
        result.addresslineController = TextEditingController();
        result.addresslineController.text = value;
        result.addressline = value;
      }
      else if (index == 7) {
        result.itemDisplayController = TextEditingController();
        result.itemDisplayController.text = value;
        result.itemDisplay = value;
      } else if (index == 8) {
        result.typeDisplayController = TextEditingController();
        result.typeDisplayController.text = value;
        result.typeDisplay = value;
      } else if (index == 9) {
        result.revenueController = TextEditingController();
        result.revenueController.text = value;
        result.revenue = value;
      }
    }
    else if (type == "N") {
      if (index == 1) {
        result.phoneController = TextEditingController();
        result.phoneController.text = nvalue.toString();
        result.phoneNumber = nvalue.toString();
      }
    }
    else if (type == "SP") {
      if (index == 2) {
        result.provinceId = svalue;
      }
    } else if (type == "SD") {
      if (index == 3) {
        result.districtId = svalue;
      }

    }
    else if (type == "ST") {
      if (index == 4) {
        result.townId = svalue;
      }
    }
    else {
      if (index == 6) {
        result.areaDisplay = svalue;
      }
    }
  }

  Future<HttpResponseMessage> sendData() async {
    //alert(content: result.toJson().toString());
    HttpResponseMessage tempResult = new HttpResponseMessage();
    //tempResult.statusCode =200;
    //tempResult.content = "test111";
    //return tempResult;
    //result.provinceId = result.districtId = result.townId = 0;
    //result.areaDisplay = 0;result.itemDisplay = "empy";result.areaDisplay = 0;
    //result.revenue ="empty";result.typeDisplay = "empty";
    if (result == null) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu object");
    }
    if (ExString(result.merchantName.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Chưa nhập tên CH");
    }
    if (ExString(result.phoneNumber.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Chưa nhập số điện thoại");
    }
    if (ExString(result.provinceId.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu tỉnh/thành phố");
    }
    if (ExString(result.districtId.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu quận/huyện");
    }
    if (ExString(result.townId.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu phường/xã");
    }
    if (ExString(result.addressline.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu địa chỉ chi tiết");
    }
    if (ExString(result.areaDisplay.toString()).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu diện tích TB");
    }
    if (ExString(result.itemDisplay).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu mặt hàng trưng bày");
    }
    if (ExString(result.typeDisplay).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu CT trưng bày");
    }
    if (ExString(result.revenue).isNullOrWhiteSpace()) {
      return new HttpResponseMessage(statusCode: 500,content: "Thiếu doanh thu");
    }
    // if (ExString(result.photo).isNullOrWhiteSpace()) {
    //   return new HttpResponseMessage(statusCode: 500,content: "chưa chụp hình thực tế");
    // }
    if(lstP.length <2)
      {
        return new HttpResponseMessage(statusCode: 500,content: "Vui lòng chụp đủ 2 tấm hình");
      }
    result.photo  = "";
    for(int i = 0;i < lstP.length;i++)
      {
        result.photo +=( ExString(result.photo).isNullOrWhiteSpace()?"": ";" )+ lstP[i].photoServer;
      }

    await uploadResultCreateShop(result: result).then((HttpResponseMessage value) {
      if(value.statusCode == 200){
        tempResult = new HttpResponseMessage(statusCode: 200,content: "Đã tạo dữ liệu thành công.");
      }else{
        tempResult = value;
      }
    });
    return tempResult;
  }

  Future<void> clearData() async {
    result.addressline =result.merchantName = result.phoneNumber = result.itemDisplay = result.typeDisplay = result.photo = "";
    result.areaDisplay = null;
    lstP.clear();

    change(null, status: RxStatus.success());
  }

}
