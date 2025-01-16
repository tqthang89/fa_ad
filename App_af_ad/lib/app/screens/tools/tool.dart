import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_button.dart';
import 'package:syngentaaudit/app/screens/tools/tool_controller.dart';

class ToolView extends GetView<ToolController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Scaffold(
          appBar: BaseAppBar(
            title: Text('Công cụ'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              Get.back();
            },
          ),
          body: Container(
            alignment: Alignment.center,
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "Bạn chỉ dùng các chức năng này khi được sự hướng dẫn trực tiếp từ IT hoặc Admin. Xin cám ơn !",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: BaseButton(
                    titleColor: Colors.white,
                    title: 'Hỗ trợ online',
                    onPressed: () {
                      controller.supportOnline();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: BaseButton(
                    titleColor: Colors.white,
                    title: 'Download DB from server',
                    onPressed: () {
                      controller.downloadDB();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: BaseButton(
                    titleColor: Colors.white,
                    title: 'Upload DB to server',
                    onPressed: () {
                      controller.uploadDB();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
