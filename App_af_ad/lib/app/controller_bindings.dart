import 'package:get/get.dart';
import 'package:syngentaaudit/app/screens/login/login_controller.dart';
import 'package:syngentaaudit/app/screens/panel/account/account_controller.dart';
import 'package:syngentaaudit/app/screens/panel/home/home_controller.dart';
import 'package:syngentaaudit/app/screens/panel/panel_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/create_shop/create_shop_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/download/download_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/map/map_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_list/shop_list_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_panel_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/upload/upload_controller.dart';
import 'package:syngentaaudit/app/screens/tools/tool_controller.dart';
import 'package:syngentaaudit/app/screens/welcome/welcome_controller.dart';

import 'apple/shop/ShopAppleController.dart';
import 'apple/shoplist/ShopListAppleController.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeController>(
      () => WelcomeController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),fenix: true
    );
    Get.lazyPut<PanelController>(
      () => PanelController(), fenix: true
    );
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<AccountController>(
      () => AccountController(), fenix: true
    );
    Get.lazyPut<ShopListController>(() => ShopListController(), fenix: true);
    Get.lazyPut<DownloadController>(() => DownloadController(), fenix: true);
    Get.lazyPut<UploadController>(() => UploadController(), fenix: true);
    Get.lazyPut<ShopPanelController>(() => ShopPanelController(), fenix: true);
    Get.lazyPut<MapController>(() => MapController(), fenix: true);
    Get.lazyPut<ToolController>(
      () => ToolController(),fenix: true
    );
    Get.lazyPut<CreateShopController>(() => CreateShopController(), fenix: true);
    Get.lazyPut<ShopListAppleController>(() => ShopListAppleController(), fenix: true);
    Get.lazyPut<ShopAppleController>(() => ShopAppleController(), fenix: true);
  }
}
