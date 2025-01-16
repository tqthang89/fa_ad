import 'package:get/get.dart';
import 'package:syngentaaudit/app/screens/record/record_controller.dart';

class RecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordController>(() => RecordController());
  }
}
