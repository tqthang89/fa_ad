import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_bottom_navigator_bar.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_panel_controller.dart';

class ShopPanelView extends GetView<ShopPanelController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text(controller.getPageName()),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: (){
             controller.onBack();
            },
            //rightIcon: Icon(Icons.add),
            //rightClick: (){
            //  Get.toNamed("/create",arguments: <dynamic>[],preventDuplicates: false);
            //},
          ),
          bottomNavigationBar: BaseBottomNavigationBar(
            currentIndex: controller.currentIndex,
            bars: controller.tabs,
            onTap: (index) {
              controller.changeTab(index);
            },
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: Stack(
                    children: [
                      IndexedStack(
                        index: controller.currentIndex,
                        children: controller.tabs.map((e) => e.page).toList(),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return controller.onBack();
        }));
  }
}
