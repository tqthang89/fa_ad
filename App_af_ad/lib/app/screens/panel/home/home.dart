import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/screens/panel/home/elements/menu_item.dart'
    as mu;

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;

    return controller.obx((state) => Container(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                  width: size.width,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          child: VerticalDivider(
                            color: AppStyle.primary,
                            thickness: 5,
                          ),
                        ),
                        Text(
                          'Danh sách module (Version:' +
                              controller.version +
                              ')',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 7,
                      crossAxisCount: 3),
                  itemBuilder: (_, index) => InkWell(
                    child: mu.MenuItem(
                      tabInfo: controller.tabs[index],
                      size: size,
                    ),
                    onTap: () {
                      controller.onMenuTap(controller.tabs[index]);
                    },
                  ),
                  itemCount: controller.tabs.length,
                ),
              )),
            ],
          ),
        ));
  }
}
