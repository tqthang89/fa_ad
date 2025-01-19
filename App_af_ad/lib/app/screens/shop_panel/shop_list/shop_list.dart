import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_textfield.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_list/element/shop_item.dart';

import 'shop_list_controller.dart';

class ShopListView extends GetView<ShopListController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Container(
          width: size.width,
          child: Column(
            children: [
              Container(
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: BaseTextField(
                          borderColor: Colors.grey[300],
                          backgroundColor: const Color(0xFFF3F6FF),
                          controller: controller.searchController,
                          rightIcon: 'assets/icons/ic_search.png',
                          isPassword: false,
                          radius: 5,
                          height: 30,
                          placeHolder: 'Tìm tên cửa hàng...',
                          onChanged: (content) {
                            controller.onSearchChange(content);
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          'assets/icons/ic_map.png',
                          color: AppStyle.primary,
                          fit: BoxFit.fill,
                        ),
                      ),
                      onTap: () {
                        controller.toMap();
                      },
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.add,  // Sử dụng icon "add" mặc định của Flutter
                          color: AppStyle.primary,  // Áp dụng màu sắc chính từ AppStyle
                          size: 30.0,  // Kích thước của icon, có thể thay đổi theo nhu cầu
                        ),
                      ),
                      onTap: () {
                        controller.toCreateShop();
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.lstShop.length,
                itemBuilder: (context, index) {
                  return ShopItem(
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
        ));
  }
}
