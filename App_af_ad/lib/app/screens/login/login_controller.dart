import 'package:flutter/cupertino.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Shared.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/routers/app_routes.dart';

import '../../base_controller.dart';

class LoginController extends BaseController {
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  void onInit() async{
    super.onInit();
    //var db = new DatabaseHelper();
    //await db.updateData();
    change(null, status: RxStatus.success());
  }

  Future<void> handleLogin(BuildContext context) async {
    if (userController.text.isNullOrWhiteSpace()) {
      alert(
        content: "Please Type UserName",
      );
      return;
    } else if (passController.text.isNullOrWhiteSpace()) {
      alert(
        content: "Please Type PassWord",
      );
      return;
    } else {
      if (await Utility.isInternetConnected()) {
        await showProgess();
        Map<String, String> params = new Map();
        params["username"] = userController.text;
        params["password"] = passController.text;
        HttpResponseMessage response =
            await HttpUtils.post(url: Urls.LOGIN, body: params, isLogin: true);
        await hideProgess();
        try {
          if (response.statusCode == 200) {
            LoginInfo login = LoginInfo.fromJson(response.content);
            print(login.toJson().toString());
            await Shared.setUser(login);
            if(login.typeid != 10)
              Get.offNamed(Routes.PANEL);
            else
              Get.offNamed(Routes.SHOPLISTAPPLE);
          } else {
            alert(
              content: response.content.toString(),
            );
            return;
          }
        } catch (ex) {
          alert(
            content: ex.toString(),
          );
          return;
        }
      } else {
        errorInterner();
      }
    }
  }
}
