import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

import 'ShopAppleController.dart';

class ShopAuditApple extends GetView<ShopAppleController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => WillPopScope(
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text('Workplace'),
            rightIsNotify: false,
            height: 50,
            isShowBackGround: false,
            leftIcon: Icons.arrow_back_ios,
            leftClick: () {
              controller.onBack();
            },
            //rightIcon: Icon(Icons.add),
            rightClick: () {},
          ),
          body: Column(children: [
            SizedBox(height: 20,),
            TextField(
              controller: controller.tx,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide:
                      new BorderSide(color: Colors.teal)),
                  hintText: 'Address',
                  helperText:
                  'Please enter the detailed address of the place of work ( 2056 char)',
                  labelText: 'Address',
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.green,
                  ),
                  prefixText: '',

                  suffixText: '',
                  suffixStyle:
                  const TextStyle(color: Colors.green)),
            ),
            SizedBox(height: 20,),
            checkInOut()
          ],),
        )));
  }

  Widget checkInOut() {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 104),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    color: const Color(0xFF40A9FF),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    child: !ExString(controller.imageCheckInPath.value)
                        .isNullOrWhiteSpace()
                        ? Padding(
                        padding: EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child:
                            // Image.file(
                            //   new File(controller.imageCheckInPath.value),
                            //   fit: BoxFit.contain,
                            //   alignment: Alignment.center,
                            //   width: 140,
                            //   height: 104,
                            // )
                            CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: controller.imageCheckInPath.value,
                              placeholder: (context, url) => Container(
                                padding: EdgeInsets.all(10),
                                child: Container(
                                  width: 140,
                                  height: 104,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            )
                        ))
                        : InkWell(
                      child: Container(
                        width: 140,
                        height: 104,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F7FF),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: const Color(0xFF40A9FF),
                              size: 30,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Check in",
                              style: TextStyle(
                                  color: const Color(0xFF40A9FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      onTap: () => controller.checkOutProcess(0), /*controller.checkInProcess(shop)*/))),
            LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    color: const Color(0xFF40A9FF),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    child:
                    !ExString(controller.imageCheckOutPath.value)
                        .isNullOrWhiteSpace()
                        ? Padding(
                        padding: EdgeInsets.all(2),
                        child:
                        // Image.file(
                        //   new File(controller.imageCheckOutPath.value),
                        //   fit: BoxFit.contain,
                        //   alignment: Alignment.center,
                        //   width: 140,
                        //   height: 104,
                        // )
                        CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: controller.imageCheckOutPath.value,
                          placeholder: (context, url) => Container(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              width: 140,
                              height: 104,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        )
                    )
                        : InkWell(
                      child: Container(
                        width: 140,
                        height: 104,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6F7FF),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              color: const Color(0xFF40A9FF),
                              size: 30,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Check out",
                              style: TextStyle(
                                  color: const Color(0xFF40A9FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      onTap: () => controller.checkOutProcess(1),
                    ))),
          ],
        ),
      ),
    );
  }
}
