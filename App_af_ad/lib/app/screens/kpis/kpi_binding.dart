import 'package:get/get.dart';
import 'package:syngentaaudit/app/screens/kpis/kpi_controller.dart';

import 'kpi_promotion_controller.dart';

class KPIBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KPIController>(() => KPIController());
    Get.lazyPut<KPIPromotionController>(() => KPIPromotionController());
  }
}
