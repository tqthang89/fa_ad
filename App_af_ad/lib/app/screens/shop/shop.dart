import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/screens/shop/shopComponents/ShopTab.dart';
import 'package:syngentaaudit/app/screens/shop/shopViews/ShopDetail.dart';
import 'package:syngentaaudit/app/screens/shop/shopViews/shopAudit.dart';
import 'package:syngentaaudit/app/screens/shop/shopViews/shopReport.dart';
import 'package:syngentaaudit/app/screens/shop/shop_controller.dart';

class Shop extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopState();
  }
}

class ShopState extends State<Shop> with SingleTickerProviderStateMixin {
  ShopController controller;
  TabController tabController;
  ShopInfo shop;
  WorkResultInfo work;
  List<String> lst;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = Get.find();
    shop = Get.arguments[0];
    work = Get.arguments[1];
    controller.work = work.obs;
    lst = [];
    lst.add('Thông tin');
    lst.add('LỊch sử');
    lst.add('Báo cáo');
    tabController = new TabController(length: lst.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return WillPopScope(
      onWillPop: () => onBackPress(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: BaseAppBar(
          title: Text('Chi tiết cửa hàng' + '('+work.rowId.toString()+')'),
          rightIsNotify: false,
          isShowBackGround: false,
          flexibleSpace: Container(
            height: size.height / 5 + 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                     AppStyle.primary,
                    AppStyle.primaryDart
                    //const Color(0xFF0A7D60)
                  ],
                ),
              ),
            ),
          ),
          height: 50,
          leftIcon: Icons.arrow_back_ios_new,
          leftClick: onBackPress,
          rightIcon: Icon(Icons.mic_none_rounded),
          rightClick: () => controller.onRecord(shop),
        ),
        body: shopBody(),
      ),
    );
  }

  Widget shopBody() {
    return Container(
      height: Utility.getHeightScreen(context),
      width: Utility.getWidthScreen(context),
      color: Colors.white,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: ShopTab()
                      .tabBar(tabController: tabController, lst: lst))),
          Align(
            alignment: Alignment.center,
            child: Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [ShopDetail(), ShopReport(), ShopAudit()],
                    ))),
          ),
        ],
      ),
    );
  }

  onBackPress() {
    Get.back();
  }
}
