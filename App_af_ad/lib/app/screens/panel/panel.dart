import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_bottom_navigator_bar.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

import 'panel_controller.dart';

class PanelView extends GetView<PanelController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    double imageSize = size.width / 4;
    return controller.obx((state) => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text(controller.getPageName()),
            rightIsNotify: controller.currentIndex == 0 ? true : false,
            isShowBackGround: controller.currentIndex == 0 ? true : false,
            flexibleSpace: Container(
              height: size.height / 5 + 100,
              child: controller.currentIndex == 0
                  ? Stack(
                      children: [
                        ClipPath(
                          clipper: CurvedBottomClipper(),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  AppStyle.primaryDart,
                                  AppStyle.primary,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                ),
                                width: imageSize,
                                height: imageSize,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: controller.loginInfo.avatar,
                                  placeholder: (context, url) => Container(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                                child: Text(
                                  controller.loginInfo.employeeName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            const Color(0xFF15D48A),
                            const Color(0xFF0A7D60)
                          ],
                        ),
                      ),
                    ),
            ),
            height: controller.currentIndex == 0 ? size.height / 5 + 100 : 50,
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

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 1.5 / 5;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -30, size.height - roundingHeight * 2, size.width + 30, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
