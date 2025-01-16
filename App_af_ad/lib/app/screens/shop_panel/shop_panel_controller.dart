import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/TabInfo.dart';
import 'package:syngentaaudit/app/screens/shop_panel/download/download.dart';
import 'package:syngentaaudit/app/screens/shop_panel/download/download_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_list/shop_list_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/upload/upload.dart';
import 'package:syngentaaudit/app/screens/shop_panel/upload/upload_controller.dart';

import '../../base_controller.dart';
import 'shop_list/shop_list.dart';

class ShopPanelController extends BaseController {
  List<TabInfo> tabs;
  int currentIndex = 0;
  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if (tabs == null) {
      tabs = new List.empty(growable: true);
      tabs.add(new TabInfo(
          id: 0,
          title: 'Cửa hàng',
          icon: 'assets/icons/ic_shop.png',
          isSelected: true,
          page: ShopListView()));
      tabs.add(new TabInfo(
          id: 1,
          title: 'Download',
          icon: 'assets/icons/ic_download.png',
          isSelected: false,
          page: DownloadView()));
      tabs.add(new TabInfo(
          id: 2,
          title: 'Upload',
          icon: 'assets/icons/ic_upload.png',
          isSelected: false,
          page: UploadView()));
    }
    change(null, status: RxStatus.success());
  }

  String getPageName() {
    return tabs[currentIndex].title;
  }

  void changeTab(int index) {
    DownloadController downloadController = Get.find<DownloadController>();
    if (downloadController.isDownload) {
      alert(content: "Đang tải dữ liệu vui lòng không thao tác !");
      return;
    }
    this.currentIndex = index;
    tabs.forEach((element) {
      if (element.id == currentIndex) {
        element.isSelected = true;
      } else {
        element.isSelected = false;
      }
    });
    switch (currentIndex) {
      case 0:
        ShopListController shopListController = Get.find<ShopListController>();
        shopListController.init();
        break;
      case 1:
        DownloadController downloadController = Get.find<DownloadController>();
        downloadController.init();
        break;
      case 2:
        UploadController uploadController = Get.find<UploadController>();
        uploadController.init();
        break;
    }

    change(null, status: RxStatus.success());
  }

  Future<bool> onBack() async {
    DownloadController downloadController = Get.find<DownloadController>();
    if (downloadController.isDownload) {
      alert(content: "Đang tải dữ liệu vui lòng không thao tác !");
    } else {
      Get.back();
    }
    return false;
  }
}
