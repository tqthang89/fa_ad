import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_gradient_button.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/screens/kpis/surveyComponents/albumImages.dart';
import 'package:syngentaaudit/app/screens/shop_panel/create_shop/create_shop_controller.dart';
import 'package:syngentaaudit/app/screens/shop_panel/create_shop/element/create_shop_item.dart';

class CreateShop extends GetView<CreateShopController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: WillPopScope(
        onWillPop: controller.onBack,
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text("Tạo mới cửa hàng"),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.lstField.length,itemBuilder: (buildContext,index){
                    return CreateShopItem(controller: controller,item: controller.lstField[index],index: index,context: context,);
                  },),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: BaseGradientButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        controller.sendData().then((value) {
                          if(value.statusCode == 200 && !ExString(value.content).isNullOrWhiteSpace()){
                            controller.confirmOK(value.content, (){

                              Navigator.pop(context);
                              Navigator.of(context).pop();
                              controller.clearData();
                              //controller.clearData();
                            });
                            //Get.toNamed("/create",arguments: <dynamic>[],preventDuplicates: false);
                          }else if(value.statusCode == 500 && !ExString(value.content).isNullOrWhiteSpace()){
                            controller.alert(content: value.content);
                          }
                        });
                      },
                      text: 'Hoàn thành',
                    ),
                  )
                )
              ],
            )


          ),
        ))));
  }
}
