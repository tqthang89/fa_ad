import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/base/TabInfo.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/routers/app_routes.dart';
import 'package:syngentaaudit/app/screens/panel/account/account.dart';

import '../../base_controller.dart';
import 'ShopListAppleView.dart';


class ShopListAppleController extends BaseController {
  TextEditingController searchController = new TextEditingController();
  Timer timeHandle;

  List<ShopInfo> lstShop = new List.empty(growable: true);
  List<TabInfo> tabs;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    for (int i = 0; i <= 9; i++) {
      ShopInfo shop = new ShopInfo(i+1, "Store " + (i +1).toString(), "Store " + (i +1).toString(),"Store " + i.toString(),"Work Address",
      "090000000",0,0,"","1","",false,20220701,false,1,"",1
      );
      lstShop.add(shop);
    }
    if (tabs == null) {
      tabs = new List.empty(growable: true);
      tabs.add(new TabInfo(
          id: 0,
          title: 'Home',
          icon: 'assets/icons/ic_home.png',
          isSelected: true,
          page: ShopListAppleView()));
      tabs.add(new TabInfo(
          id: 1,
          title: 'Logout',
          icon: 'assets/icons/ic_user.png',
          isSelected: false,
          page: AccountView()));
      tabs.add(new TabInfo(
          id: 2,
          title: 'Clear Account & Data',
          icon: 'assets/icons/ic_user.png',
          isSelected: false,
          page: AccountView()));
    }
    change(null, status: RxStatus.success());
  }

  bool onBack() {
    Get.back();
    return false;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(TabInfo ti) {
    if(ti.id ==1)
    {
      confirmApple(
          content: "Do you want to log out of the application ?",
          onConfirm: () async {
            await Shared.setUser(null);
            Get.offAllNamed(Routes.LOGIN);
          },
          onCancel: () {
            Navigator.of(Get.context).pop();
          });
    }
    if(ti.id ==2)
    {
      confirmApple(
          content: "Do you want to delete your account and all your data?",
          onConfirm: () async {
            LoginInfo user = await Shared.getUser();
            HttpResponseMessage response =
            HttpResponseMessage(statusCode: 202, content: "Start send...");
            Map<String, String> param = new Map();
            param["FUNCTION"] = "APPLE_EMPLOYEE";
            param["ActionType"] = "3";
            param["Email"] = user.loginName;
            response = await HttpUtils.post(body: param, url: Urls.UPLOAD_FILE);
            print(response.statusCode.toString() + '-' + response.content.toString());
            if (response.statusCode == 200) {
              await Shared.setUser(null);
              Get.offAllNamed(Routes.LOGIN);
            }
          },
          onCancel: () {
            Navigator.of(Get.context).pop();
          });
    }
  }

  void confirmApple(
      {String title = 'Message',
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
        textConfirm: 'Yes',
        textCancel: 'Cancel',
        cancelTextColor: Colors.red[500],
        confirmTextColor: Colors.blue[500],
        onConfirm: onConfirm != null
            ? onConfirm
            : () {
          Get.back();
        },
        onCancel: onCancel);
  }
}
