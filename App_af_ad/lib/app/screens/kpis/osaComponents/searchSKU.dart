import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/core/Utility.dart';

import '../kpi_controller.dart';

class SearchSKU extends StatelessWidget {
  final KPIController controller;
  final ShopInfo shop;

  SearchSKU({@required this.controller, @required this.shop});

  @override
  Widget build(BuildContext context) {
    return Obx(() => AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          width: Utility.getWidthScreen(context),
          height: controller.searchHeight.value,
          duration: Duration(seconds: 1),
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Tên sản phẩm: "),
                    ),
                    Expanded(
                        flex: 2,
                        child: TextFormField(
                          maxLines: 1,
                          controller: controller.selectProductOSATEController,
                          decoration: InputDecoration(
                            counterText: "",
                            isDense: true,
                            contentPadding: EdgeInsets.all(5),
                            fillColor: Colors.white,
                            suffixIcon: InkWell(
                              child: Icon(
                                Icons.clear,
                                size: 20,
                              ),
                              onTap: () async {
                                controller.selectProductOSATEController.clear();
                                controller.selectProductOSA = "";
                                await controller.searchDataOsa().then((value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                });
                              },
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minWidth: 35,
                              minHeight: 35,
                            ),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onChanged: (String content) async {
                            await new Future.delayed(
                                new Duration(milliseconds: 500), () async {
                              controller.selectProductOSA = content;
                              await controller.searchDataOsa();
                            });
                          },
                        )),
                    LimitedBox(
                      maxWidth: 40,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.expand),
                          color: const Color(0xFF0A7D60),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            if (controller.searchHeight.value == 60.0) {
                              controller.searchHeight.value = 120.0;
                              Timer(Duration(milliseconds: 500), () {
                                controller.eSearchDetail.value = true;
                              });
                            } else {
                              controller.searchHeight.value = 60.0;
                              controller.eSearchDetail.value = false;
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 50),
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Loại sản phẩm: "),
                            ),
                            Expanded(
                                flex: 2,
                                child: DropdownButton<String>(
                                  value: controller.selectKeyBrandOSA.value,
                                  items: controller.lstBrandOSA
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  isDense: true,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  onChanged: (String value) async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    controller.selectKeyBrandOSA.value = value;
                                    await controller.searchDataOsa();
                                  },
                                )),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("SKU chưa hoàn thành: "),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Obx(() => Checkbox(
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          value: controller.eNotDoneOSA.value,
                                          onChanged: (bool value) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                            controller.eNotDoneOSA.value =
                                                value;
                                            controller.searchDataOsa();
                                          },
                                        )))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  visible: controller.eSearchDetail.value,
                )
              ],
            ),
          ),
        ));
  }
}
