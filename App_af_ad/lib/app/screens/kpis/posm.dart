import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_view_photo_dialog.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/PosmResultModel.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/screens/kpis/surveyComponents/albumImages.dart';

import 'kpi_controller.dart';

class Posm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PosmState();
  }
}

class PosmState extends State<Posm> {
  KPIController controller;
  ShopInfo shop;
  WorkResultInfo work;
  MasterInfo kpi;

  @override
  void initState() {
    controller = Get.find();
    shop = Get.arguments[0];
    work = Get.arguments[1];
    kpi = Get.arguments[2];
    controller.work = work.obs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDataPosm(shop, work, kpi);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          appBar: BaseAppBar(
            title: Text(kpi.name),
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
                    ],
                  ),
                ),
              ),
            ),
            height: 50,
            leftIcon: Icons.arrow_back_ios_new,
            leftClick: controller.onBackPress,
            rightIcon: Icon(Icons.mic_none_rounded),
            rightClick: () => controller.onRecord(shop),
          ),
          body: posmList(),
        ));
  }

  Widget posmList() {
    return Container(
      height: Utility.getHeightScreen(context),
      width: Utility.getWidthScreen(context),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      color: const Color(0xFFE5E5E5),
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              margin: EdgeInsets.all(0),
              child: Obx(
                () => MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: controller.lstPosm != null &&
                            controller.lstPosm.length != 0
                        ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: controller.lstPosm.length,
                            itemBuilder: (BuildContext context, int index) {
                              return itemListView(
                                  context, controller.lstPosm[index], index);
                            })
                        : Center()),
              ))),
    );
  }

  Widget itemListView(
      BuildContext context, Rx<PosmResultModel> item, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      color: Colors.white,
      width: Utility.getWidthScreen(context),
      margin: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(2),
                // child: Text(
                //   !ExString(item.value.posmName).isNullOrWhiteSpace()
                //       ? item.value.posmName
                //       : "Posm ko có tên.",
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // )),
                child: InkWell(
                  child: Text(
                    !ExString(item.value.posmName)
                        .isNullOrWhiteSpace()
                        ? item.value.posmName
                        : "POSM ko có tên.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    if (!ExString(item.value.posmName)
                        .isNullOrWhiteSpace()) {
                      if (!ExString(item.value.photo)
                          .isNullOrWhiteSpace()) {
                        BaseViewPhotoDialog.show(
                            item.value.photo, context);
                      }
                    }
                  },
                )),
            Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Obx(() => Theme(
                                          data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)))),
                                          child: CheckboxListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text(
                                                "Có",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              value: item.value.value != null &&
                                                      item.value.value == 1
                                                  ? true
                                                  : false,
                                              onChanged: !work.locked
                                                  ? (bool check) {
                                                      if (!work.locked) {
                                                        controller
                                                            .getUpdateDataPosm(
                                                                item:
                                                                    item.value,
                                                                checkYes: check,
                                                                work: work);
                                                      }
                                                    }
                                                  : null,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading)))),
                                  Expanded(
                                      child: Obx(() => Theme(
                                          data: ThemeData(
                                              checkboxTheme: CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25)))),
                                          child: CheckboxListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text("Không",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                              value: item.value.value != null &&
                                                      item.value.value == 0
                                                  ? true
                                                  : false,
                                              onChanged: !work.locked
                                                  ? (bool check) {
                                                      if (!work.locked) {
                                                        controller
                                                            .getUpdateDataPosm(
                                                                item:
                                                                    item.value,
                                                                checkNo: check,
                                                                work: work);
                                                      }
                                                    }
                                                  : null,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading))))
                                ],
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: const Color(0xFFD9D9D9))),
                                  child: Obx(() => item.value.lstAns != null &&
                                          item.value.lstAns.length != 0
                                      ? Padding(
                                          child: DropdownButton<MasterInfo>(
                                            value: item.value.itemSelected,
                                            items: item.value.lstAns
                                                .map((MasterInfo value) {
                                              return DropdownMenuItem<
                                                  MasterInfo>(
                                                value: value,
                                                child: Text(value.name),
                                              );
                                            }).toList(),
                                            isDense: true,
                                            isExpanded: true,
                                            underline: SizedBox(),
                                            onChanged: !work.locked &&
                                                    item.value.value == 1
                                                ? (MasterInfo value) async {
                                                    item.value.itemSelected =
                                                        value;
                                                    item.value.status =
                                                        value.id;
                                                    await controller
                                                        .updateDataPosm(
                                                            work: work,
                                                            item: item.value);
                                                  }
                                                : null,
                                          ),
                                          padding:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                        )
                                      : Center(
                                          child: Text(
                                              "Không có thông tin danh sách câu trả lời."),
                                        )))),
                        ],
                      ),
                    )
                  ],
                )),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50),
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Số lượng: ${item.value.target}',
                            style: TextStyle(fontSize: 12, color: Colors.red)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Số lượng thực tế: ',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Obx(
                            () => TextFormField(
                              controller: item.value.textController,
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: true, decimal: false),
                              maxLength: 5,
                              decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              enabled: !work.locked && item.value.value == 1
                                  ? true
                                  : false,
                              onChanged: (String content) async {
                                await new Future.delayed(
                                    new Duration(milliseconds: 500), () async {
                                  try {
                                    int temp =
                                        !ExString(content).isNullOrWhiteSpace()
                                            ? int.parse(content)
                                            : null;
                                    item.value.quantity = temp;
                                    await controller
                                        .updateDataPosm(
                                            work: work, item: item.value)
                                        .then((value) => FocusScope.of(context)
                                            .requestFocus(new FocusNode()));
                                  } catch (e) {
                                    item.value.value = null;
                                    await controller
                                        .updateDataPosm(
                                            work: work, item: item.value)
                                        .then((value) => FocusScope.of(context)
                                            .requestFocus(new FocusNode()));
                                  }
                                });
                              },
                            ),
                          )),
                    ],
                  )),
            ),
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50),
                child: TextFormField(
                  initialValue: item.value.comment,
                  enabled: !work.locked ? true : false,
                  onChanged: !work.locked
                      ? (value) async {
                          await new Future.delayed(
                              new Duration(milliseconds: 50), () async {
                            try {
                              item.value.comment = value;
                              await controller.updateDataPosm(
                                  work: work, item: item.value);
                            } catch (ex) {}
                          });
                        }
                      : null,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: "Ghi chú"),
                )),
            Container(
                height: 80,
                child: Visibility(
                  visible: true,
                  child: Row(
                    children: [
                      DottedBorder(
                          color: const Color(0xFF32B768),
                          padding: EdgeInsets.zero,
                          strokeWidth: 1,
                          dashPattern: [
                            1,
                            2,
                          ],
                          child: SizedBox(
                            width: Utility.getWidthScreen(context) / 2.5,
                            child: TextButton.icon(
                                onPressed: !work.locked
                                    ? () {
                                        controller.startCameraKPIs(
                                            work: work,
                                            shop: shop,
                                            kpi: kpi,
                                            itemPosm: item.value);
                                      }
                                    : null,
                                style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(20),
                                    backgroundColor: const Color(0xFFF6FFED)),
                                icon: Icon(Icons.camera_alt_rounded,
                                    color: const Color(0xFF32B768), size: 30),
                                label: Text("")),
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton.icon(
                            onPressed: () => Get.to(
                                AlbumImages(photos: item.value.lstPhoto)),
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.all(20),
                                primary: const Color(0xFFA6A6A6),
                                backgroundColor: const Color(0xFFD9D9D9)),
                            icon: Icon(
                              Icons.photo,
                              size: 30,
                            ),
                            label: item.value.lstPhoto != null &&
                                    item.value.lstPhoto.length != 0
                                ? Text('${item.value.lstPhoto.length} hình')
                                : Text("")),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
