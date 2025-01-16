import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/routers/app_routes.dart';

import '../../../base_controller.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

class ShopListController extends BaseController {
  TextEditingController searchController = new TextEditingController();
  Timer timeHandle;

  RxList<ShopInfo> lstShop = <ShopInfo>[].obs;
  RxList<ShopInfo> _listTemp = <ShopInfo>[].obs;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    try
    {
      var db = new DatabaseHelper();
      await db.updateData();
      print('Database Update Done');
    }catch(ex)
    {
      alert(content: ex.toString());
    }
    try {
      List<ShopInfo> data = await AuditContext.getAllShopToDay();
      lstShop.clear();
      lstShop.addAll(data);
      _listTemp = lstShop;
      change(null, status: RxStatus.success());
    } catch (ex) {
      alert(content: ex.toString());
      return;
    }
  }

  void toMap() {
    Get.toNamed(Routes.MAP,
        arguments: <dynamic>[lstShop], preventDuplicates: false);
  }

  void onSearchChange(String content) {
    if (timeHandle != null) {
      timeHandle.cancel();
    }
    timeHandle = Timer(Duration(milliseconds: 200), () async {
      if (!content.isNullOrWhiteSpace()) {
        lstShop = _listTemp;
        RxList<ShopInfo> _temp = lstShop
            .where((shop) =>
                (shop.shopName.toLowerCase() + shop.shopId.toString())
                    .contains(content.toLowerCase()))
            .toList()
            .obs;
        lstShop = _temp;
        change(null, status: RxStatus.success());
      } else {
        lstShop = _listTemp;
        change(null, status: RxStatus.success());
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
