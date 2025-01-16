import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/screens/welcome/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Scaffold(
          body: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
