import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/routers/app_routes.dart';

import '../../base_controller.dart';


// ignore: must_be_immutable
class ShopAppleItem extends StatelessWidget {
  ShopInfo shop;
  Size size;
  int index;
  int lenght;
  BaseController controller;

  ShopAppleItem({this.shop, this.size, this.index, this.lenght, this.controller});

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
                color: AppStyle.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 80,
                  height: 80,
                  child: Image.asset(
                    'assets/icons/ic_shop.png',
                    color: const Color(0xFF28BE89),
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
                          visible: !(shop.address.toString() != null && shop.address.toString() != ""),
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
                                      !(shop.address.toString() != null && shop.address.toString() != "")
                                          ? shop.address
                                          : '',
                                      style: TextStyle(color: AppStyle.text_base_Color),
                                    ),
                                  ))
                            ],
                          )),
                      Visibility(
                        child: Container(
                          margin: EdgeInsets.only(top: 5),
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Text(
                                        'OOS: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '0%',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Text(
                                        'SOS: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('0%',
                                        style: TextStyle(
                                            color: AppStyle.primary,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        visible: false,
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 5),
                      //   padding: EdgeInsets.all(5),
                      //   width: size.width,
                      //   decoration: BoxDecoration(
                      //       color: AppStyle.primary.withOpacity(0.2),
                      //       borderRadius: BorderRadius.all(Radius.circular(20)),
                      //       border: Border.all(
                      //         color: AppStyle.primary,
                      //       )),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(left: 5, right: 5),
                      //         width: 10,
                      //         height: 10,
                      //         child: Image.asset('assets/icons/ic_dot.png',
                      //             color: AppStyle.primary),
                      //       ),
                      //       Expanded(
                      //           child: Container(
                      //         alignment: Alignment.centerLeft,
                      //         child: Text(
                      //           'Giờ làm việc từ 7h30 - 17h30',
                      //           style: TextStyle(color: AppStyle.text_base_Color),
                      //         ),
                      //       ))
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ))
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(Paths.SHOPAPPLE,
            arguments: <dynamic>[shop], preventDuplicates: false);
      },
    );
  }
}
