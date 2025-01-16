
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_bottom_navigator_bar.dart';

import 'ShopAppleItem.dart';
import 'ShopListAppleController.dart';


class ShopListAppleView extends GetView<ShopListAppleController> {



  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) =>
    // WillPopScope(
    // child:
    Scaffold(
      appBar: BaseAppBar(
        title: Text('Stores'),
        rightIsNotify: false,
        height: 50,
        isShowBackGround: false,
        // leftIcon: Icons.arrow_back_ios,
        // leftClick: () {
        //   controller.onBack();
        // },
        //rightIcon: Icon(Icons.add),
        rightClick: () {},
      ),
      body: Container(
        width: size.width,
        child: Column(
          children: [
            Container(
              width: size.width,
              child: Row(
                children: [
                  // Expanded(
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: BaseTextField(
                  //       borderColor: Colors.grey[300],
                  //       backgroundColor: const Color(0xFFF3F6FF),
                  //       rightIcon: 'assets/icons/ic_search.png',
                  //       isPassword: false,
                  //       radius: 10,
                  //       height: 40,
                  //       placeHolder: 'Search...',
                  //       onChanged: (content) {},
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   child: Container(
                  //     margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  //     width: 35,
                  //     height: 35,
                  //     child: Image.asset(
                  //       'assets/icons/ic_map.png',
                  //       color: AppStyle.primary,
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  //   onTap: () {},
                  // )
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.lstShop.length,
                  itemBuilder: (context, index) {
                    return ShopAppleItem(
                      shop: controller.lstShop[index],
                      size: size,
                      index: index + 1,
                      lenght: controller.lstShop.length,
                      controller: controller,
                    );
                  },
                )),
          ],
        ),
      ),
      bottomNavigationBar:
      BaseBottomNavigationBar(
        currentIndex: controller.currentIndex,
        bars: controller.tabs,
        onTap: (index) {
          controller.changeTab(controller.tabs[index]);
        },
      ),

    )
      // onWillPop: () async {
      //   return controller.onBack();
      // })
    );
  }
}
