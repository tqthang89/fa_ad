import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/routers/app_routes.dart';

import '../../base_controller.dart';

class WelcomeController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
    _startMain();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
      Permission.microphone,
      Permission.storage,
      Permission.manageExternalStorage
    ].request();
    statuses.forEach((key, value) {
      if (value.isGranted == false) return false;
    });
    return true;
  }

  Future<void> _startMain() async {
    bool check = await _checkPermissions();
    LoginInfo user = await Shared.getUser();
    if (check) {
      if (user != null) {
        Future.delayed(const Duration(seconds: 1), () {
          if(user.typeid != 10)
            Get.offAllNamed(Routes.PANEL);
          else
            Get.offAllNamed(Routes.SHOPLISTAPPLE);
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offNamed(Routes.LOGIN);
        });
      }
    } else {
      alert(content: "Bạn chưa cho phép đủ quyền ứng dụng");
      return;
    }
  }
}
