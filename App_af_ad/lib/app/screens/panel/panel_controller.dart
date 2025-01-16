import 'dart:io';

import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/TabInfo.dart';
import 'package:syngentaaudit/app/core/Shared.dart';

import '../../base_controller.dart';
import 'account/account.dart';
import 'home/home.dart';

class PanelController extends BaseController {
  List<TabInfo> tabs;
  int currentIndex = 0;
  LoginInfo loginInfo;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    loginInfo = await Shared.getUser();
    if (tabs == null) {
      tabs = new List.empty(growable: true);
      tabs.add(new TabInfo(
          id: 0,
          title: 'TRANG CHỦ',
          icon: 'assets/icons/ic_home.png',
          isSelected: true,
          page: HomeView()));
      tabs.add(new TabInfo(
          id: 1,
          title: 'TÀI KHOẢN',
          icon: 'assets/icons/ic_user.png',
          isSelected: false,
          page: AccountView()));
    }
    change(null, status: RxStatus.success());
  }

  String getPageName() {
    return tabs[currentIndex].title;
  }

  void changeTab(int index) {
    this.currentIndex = index;
    tabs.forEach((element) {
      if (element.id == currentIndex) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });
    change(null, status: RxStatus.success());
  }

  Future<bool> onBack() async {
     if (currentIndex != 0) {
       currentIndex = 0;
        tabs.forEach((element) {
          if (element.id == currentIndex) {
            element.isSelected = true;
          } else {
            element.isSelected = false;
          }
        });
        change(null, status: RxStatus.success());
    } else {
      confirm(
          content: "Bạn có muốn thoát ứng dụng không? ",
          onConfirm: () {
            exit(0);
          },
          onCancel: () {
            Get.back();
          });
    }
    return false;
  }
}
