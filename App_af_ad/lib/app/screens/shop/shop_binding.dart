import 'package:get/get.dart';
import 'package:syngentaaudit/app/screens/shop/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController());
  }
}
