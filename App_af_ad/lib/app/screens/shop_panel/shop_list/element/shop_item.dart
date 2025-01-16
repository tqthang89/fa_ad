import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';

// ignore: must_be_immutable
class ShopItem extends StatelessWidget {
  ShopInfo shop;
  Size size;
  int index;
  int lenght;
  BaseController controller;
  ShopItem({this.shop, this.size, this.index, this.lenght, this.controller});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
        width: size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Card(
                color: shop.status == 1 ? AppStyle.primary : Colors.red[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    shop.getIcon(),
                    color: shop.status == 1 ? Colors.white : Colors.red[400],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      index.toString() +
                          "/" +
                          lenght.toString() +
                          ". " +
                          shop.shopName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                      visible: !shop.address.isNullOrWhiteSpace(),
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/icons/ic_sub_location.png',
                              width: 15,
                              height: 15,
                            ),
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              !shop.address.isNullOrWhiteSpace()
                                  ? shop.address
                                  : '',
                              style: TextStyle(color: AppStyle.text_base_Color),
                            ),
                          ))
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(5),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: shop.status == 1
                            ? AppStyle.primary.withOpacity(0.2)
                            : Colors.red[400].withOpacity(0.2),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: shop.status == 1
                              ? AppStyle.primary
                              : Colors.red[400],
                        )),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          width: 10,
                          height: 10,
                          child: Image.asset('assets/icons/ic_dot.png',
                              color: shop.status == 1
                                  ? AppStyle.primary
                                  : Colors.red[400]),
                        ),
                        //Text(shop.wpDescription,overflow: TextOverflow.ellipsis)
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            !shop.wpDescription.isNullOrWhiteSpace()
                                ? shop.wpDescription
                                : '',
                            style: TextStyle(color: AppStyle.text_base_Color),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        controller.createAuditResult(shop).then((value) {
          Get.toNamed('\shop',
              arguments: <dynamic>[shop, value], preventDuplicates: false);
        });
      },
    );
  }
}
