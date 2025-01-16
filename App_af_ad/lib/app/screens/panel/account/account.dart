import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Container(
          width: size.width,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(Icons.logout),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text('Đăng xuất'),
                  )
                ],
              ),
            ),
            onTap: (){
              controller.logout();
            },
          ),
        ));
  }
}
