import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/components/base_textfield.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/screens/shop/shop_controller.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

class ShopAudit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopAuditState();
  }
}

class ShopAuditState extends State<ShopAudit> {
  ShopInfo shop;
  ShopController controller;
  final Axis scrollDirection = Axis.vertical;
  ScrollController scrollController;

  @override
  void initState() {
    shop = Get.arguments[0];
    controller = Get.find();
    controller.work.value;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDataLayoutShopAudit(shop);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          color: Colors.white,
          width: Utility.getWidthScreen(context),
          height: Utility.getHeightScreen(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  show_log_att();
                },
                child: Text('Log chấm công'),
              ),
              checkInOut(),
              secondLayout()
            ],
          ),
        ));
  }

  Widget secondLayout() {
    return Expanded(
        child: Container(
      color: const Color(0xFFF9F9F9),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [shopStatus(), listKPI()],
      ),
    ));
  }

  Future<void> show_log_att() async {
    final List<int> colorCodes = <int>[500, 10];
    print("-------------------Show image--------------");
    Size size = Get.mediaQuery.size;
    Get.defaultDialog(
        titleStyle: TextStyle(color: AppStyle.primaryDart),
        title: 'Log chấm công',
        content: Container(
          width: size.width,
          height: (size.height / 2) * 1.5,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: controller.ProcessTakePhoto.length,
              itemBuilder: (BuildContext context, int index) {
                return Visibility(
                    visible: !controller.ProcessTakePhoto[index]
                        .isNullOrWhiteSpace(),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (index + 1).toString() +
                                '/' +
                                controller.ProcessTakePhoto.length.toString() +
                                '. ' +
                                controller.ProcessTakePhoto[index],
                            style: TextStyle(color: AppStyle.text_base_Color),
                          ),
                        ))
                      ],
                    ));
              }),
        ),
        radius: 10.0);
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
                    color: const Color(0xFF32B768),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    child: Obx(() => controller.lstAttendants != null &&
                            controller.lstAttendants.length >= 1 &&
                            controller.lstAttendants[0].attendantType == 0 &&
                            !ExString(controller.imageCheckInPath.value)
                                .isNullOrWhiteSpace()
                        ? Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.file(
                                  new File(FileUtils.GetFilePath(
                                      controller.DirectoryPath,
                                      controller.imageCheckInPath.value,
                                      controller.work.value.workDate
                                          .toString())),
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                  width: 140,
                                  height: 104,
                                )))
                        : InkWell(
                            child: Container(
                              width: 140,
                              height: 104,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6FFED),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: AppStyle.primary,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Check in",
                                    style: TextStyle(
                                        color: AppStyle.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => controller.checkInProcess(shop))))),
            LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    color: const Color(0xFF32B768),
                    strokeWidth: 1,
                    dashPattern: [
                      1,
                      2,
                    ],
                    child: Obx(() => controller.lstAttendants != null &&
                            controller.lstAttendants.length >= 2 &&
                            controller.lstAttendants[1].attendantType == 1 &&
                            !ExString(controller.imageCheckOutPath.value)
                                .isNullOrWhiteSpace()
                        ? Padding(
                            padding: EdgeInsets.all(2),
                            child: Image.file(
                              new File(FileUtils.GetFilePath(
                                  controller.DirectoryPath,
                                  controller.imageCheckOutPath.value,
                                  controller.work.value.workDate.toString())),
                              fit: BoxFit.contain,
                              alignment: Alignment.center,
                              width: 140,
                              height: 104,
                            ))
                        : InkWell(
                            child: Container(
                              width: 140,
                              height: 104,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6FFED),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt_rounded,
                                    color: AppStyle.primary,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Check out",
                                    style: TextStyle(
                                        color: AppStyle.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => controller.checkOutProcess(shop),
                          )))),
          ],
        ),
      ),
    );
  }

  Widget shopStatus() {
    return Container(
      width: Utility.getWidthScreen(context),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "Trạng thái CH: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Obx(() => Container(
                    padding: EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1.0,
                          style: BorderStyle.solid,
                          color: const Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    )),
                    child: DropdownButton<MasterInfo>(
                        underline: SizedBox(),
                        isDense: true,
                        value: controller.masterInfo.value,
                        items: controller.lstMaster.map((MasterInfo value) {
                          return DropdownMenuItem<MasterInfo>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        isExpanded: true,
                        onChanged: !controller.work.value.locked
                            ? (MasterInfo value) async {
                                controller.selectedDropdownButtonHandler(
                                    shop, value);
                              }
                            : null))),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget listKPI() {
    return Obx(
      () => controller.lstKPI != null && controller.lstKPI.length != 0
          ? Expanded(
              flex: 1,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ListView.builder(
                      itemCount: controller.lstKPI.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        return itemKPI(controller.lstKPI[index]);
                      })))
          : controller.work.value.auditResult != null &&
                  controller.work.value.auditResult != 0 &&
                  controller.work.value.auditResult != 1
              ? Expanded(
                  flex: 1,
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 20, bottom: 80),
                        child: BaseTextField(
                          enabled: !controller.work.value.locked,
                          radius: 5,
                          textInputType: TextInputType.multiline,
                          maxLines: 3,
                          borderColor: const Color(0xFFE0E0E0),
                          placeHolder: 'Ghi chú...',
                          controller: controller.controllerComment,
                          focusNode: controller.focusNodeComment,
                          onChanged: (content) {
                            if (controller.timeHandle != null) {
                              controller.timeHandle.cancel();
                            }
                            controller.timeHandle =
                                Timer(Duration(milliseconds: 200), () async {
                              controller.work.value.comment = content;
                              controller.setComment(controller.work.value);
                            });
                          },
                        ),
                      )
                    ],
                  ))
              : Center(),
    );
  }

  Widget itemKPI(MasterInfo kpi) {
    return InkWell(
      onTap: () => controller.toScreen(shop, kpi),
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(2, 5, 5, 2),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 80),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Expanded(
                              flex: 1,
                              child: Text(
                                kpi.code,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                kpi.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF888888)),
                              ))
                        ],
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kpi.kpiStatus == 2
                                ? const Color(0xFFF6FFED)
                                : kpi.kpiStatus == 1
                                    ? const Color(0xFFFEFFE6)
                                    : const Color(0xFFFFFFFF),
                            border: Border.all(
                                color: kpi.kpiStatus == 2
                                    ? const Color(0xFFB7EB8F)
                                    : kpi.kpiStatus == 1
                                        ? const Color(0xFFFFF566)
                                        : const Color(0xFFD9D9D9)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle_rounded,
                              color: kpi.kpiStatus == 2
                                  ? const Color(0xFFB7EB8F)
                                  : kpi.kpiStatus == 1
                                      ? const Color(0xFFFFF566)
                                      : const Color(0xFFD9D9D9),
                              size: 7,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              kpi.kpiStatus == 2
                                  ? " Hoàn thành"
                                  : kpi.kpiStatus == 1
                                      ? " Đang làm"
                                      : " Khảo sát",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 35,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: const Color(0xFFBBBBBB),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
