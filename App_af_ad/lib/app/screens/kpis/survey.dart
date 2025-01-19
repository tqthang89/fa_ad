import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/SurveyDetailResultModel.dart';
import 'package:syngentaaudit/app/models/SurveyResultModel.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/screens/kpis/kpi_controller.dart';

import 'surveyComponents/albumImages.dart';

class Survey extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SurveyState();
  }
}

class SurveyState extends State<Survey> {
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
      controller.getData(shop, work, kpi);
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
          body: surveyList(),
        ));
  }

  Widget surveyList() {
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
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.lst.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemListView(
                              context, controller.lst[index], index);
                        })),
              ))),
    );
  }

  Widget itemListView(
      BuildContext context, Rx<SurveyResultModel> item, int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      color: Colors.white,
      width: Utility.getWidthScreen(context),
      margin: EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 60),
        child: Column(
          children: <Widget>[
            !ExString(item.value.groups).isNullOrWhiteSpace()
                ? Container(
                    height: 40,
                    margin: EdgeInsets.only(bottom: 10),
                    color: const Color(0xFFE5E5E5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: VerticalDivider(
                            thickness: 5,
                            endIndent: 5,
                            indent: 5,
                            color: const Color(0xFF32B768),
                          ),
                        ),
                        Text(
                          item.value.groups,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      !ExString(item.value.name).isNullOrWhiteSpace()
                          ? item.value.name
                          : "Câu survey ko có tên.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 5,
                ),
                layoutSureyByType(item),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: item.value.imageMin != null && item.value.imageMin > 0
                    ? true
                    : false,
                child: Container(
                  height: 20,
                  width: Utility.getWidthScreen(context),
                  child: Text(
                    'Yêu cầu chụp ${item.value.imageMin} hình',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                    textAlign: TextAlign.left,
                  ),
                )),
            Visibility(
              visible: item.value.imageMin != null && item.value.imageMin > 0
                  ? true
                  : false,
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
                                        itemSurvey: item.value);
                                  }
                                : null,
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                padding: EdgeInsets.all(20),
                                backgroundColor: const Color(0xFFF6FFED)),
                            icon: Icon(Icons.camera_alt_rounded,
                                color: const Color(0xFF32B768), size: 30),
                            label: Text('')),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton.icon(
                        onPressed: () =>
                            Get.to(AlbumImages(photos: item.value.lstPhoto)),
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            primary: const Color(0xFFA6A6A6),
                            backgroundColor: const Color(0xFFD9D9D9)),
                        icon: Icon(
                          Icons.photo,
                          size: 30,
                        ),
                        label: item.value.lstPhoto.length != 0
                            ? Text('${item.value.lstPhoto.length} hình')
                            : Text("")),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              //set rule show surveyDetail
              visible: item.value.lstDetail != null &&
                      item.value.lstDetail.length != 0 &&
                      item.value.type == "R" &&
                      !ExString(item.value.value.toString())
                          .isNullOrWhiteSpace() &&
                      item.value.value > 0
                  ? true
                  : false,
              child: widgetDetail(item.value.lstDetail),
            )
          ],
        ),
      ),
    );
  }

  Widget widgetDetail(RxList<SurveyDetailResultModel> lstDetail) {
    return LimitedBox(
        maxHeight: 120,
        child: ListView.builder(
            itemCount: lstDetail.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(child: Text(lstDetail[index].name)),
                  Expanded(
                      flex: 1,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                              width: 70,
                              height: 50,
                              child: Obx(
                                () => TextFormField(
                                  controller: lstDetail[index].textController,
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
                                  enabled: !work.locked ? true : false,
                                  onChanged: !work.locked
                                      ? (String content) async {
                                          await new Future.delayed(
                                              new Duration(milliseconds: 50),
                                              () async {
                                            try {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              int temp = !ExString(content)
                                                      .isNullOrWhiteSpace()
                                                  ? int.parse(content)
                                                  : null;
                                              lstDetail[index].value = temp;
                                              await controller.updateDataDetail(
                                                  work: work,
                                                  item: lstDetail[index]);
                                            } catch (e) {
                                              lstDetail[index].value = null;
                                              await controller.updateDataDetail(
                                                  work: work,
                                                  item: lstDetail[index]);
                                            }
                                          });
                                        }
                                      : null,
                                ),
                              ))))
                ],
              );
            }));
  }

  Widget layoutSureyByType(Rx<SurveyResultModel> item) {
    switch (item.value.type) {
      case "N":
        return Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: 70,
                    height: 50,
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
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        enabled: !work.locked ? true : false,
                        onChanged: (String content) async {
                          await new Future.delayed(
                              new Duration(milliseconds: 500), () async {
                            try {
                              if (item.value.minData != null &&
                                  item.value.minData > double.parse(content)) {
                                controller.alert(
                                    content:
                                        "Vui lòng nhập lớn hơn giá trị min ${item.value.minData}");
                                item.value.value = null;
                                await controller
                                    .updateData(work: work, item: item.value)
                                    .then((value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  item.value.textController.clear();
                                });
                              } else if (item.value.maxData != null &&
                                  item.value.maxData < double.parse(content)) {
                                controller.alert(
                                    content:
                                        "Vui lòng nhập nhỏ hơn giá trị max ${item.value.maxData}");
                                item.value.value = null;
                                await controller
                                    .updateData(work: work, item: item.value)
                                    .then((value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  item.value.textController.clear();
                                });
                              } else {
                                int temp =
                                    !ExString(content).isNullOrWhiteSpace()
                                        ? int.parse(content)
                                        : null;
                                item.value.value = temp;
                                await controller
                                    .updateData(work: work, item: item.value)
                                    .then((value) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                });
                              }
                            } catch (e) {
                              item.value.value = null;
                              await controller
                                  .updateData(work: work, item: item.value)
                                  .then((value) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                item.value.textController.clear();
                              });
                            }
                          });
                        },
                      ),
                    ))));
        break;
      case "R":
        return Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Obx(() => Theme(
                        data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
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
                                      controller.getUpdateData(
                                          item: item.value,
                                          checkYes: check,
                                          work: work);
                                    }
                                  }
                                : null,
                            controlAffinity:
                                ListTileControlAffinity.leading)))),
                Expanded(
                    child: Obx(() => Theme(
                        data: ThemeData(
                            checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)))),
                        child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(0),
                            title:
                                Text("Không", style: TextStyle(fontSize: 12)),
                            value: item.value.value != null &&
                                    item.value.value == 0
                                ? true
                                : false,
                            onChanged: !work.locked
                                ? (bool check) {
                                    if (!work.locked) {
                                      controller.getUpdateData(
                                          item: item.value,
                                          checkNo: check,
                                          work: work);
                                    }
                                  }
                                : null,
                            controlAffinity: ListTileControlAffinity.leading))))
              ],
            ));
        break;
      case "S":
        return Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: const Color(0xFFD9D9D9))),
              child: Obx(() => item.value.lstAns != null &&
                      item.value.lstAns.length != 0
                  ? Padding(
                      child: DropdownButton<SurveyAnswerInfo>(
                        value: item.value.itemSelected,
                        items: item.value.lstAns.map((SurveyAnswerInfo value) {
                          return DropdownMenuItem<SurveyAnswerInfo>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        isDense: true,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: !work.locked
                            ? (SurveyAnswerInfo value) async {
                                item.value.itemSelected = value;
                                item.value.value = value.id;
                                await controller.updateData(
                                    work: work, item: item.value);
                              }
                            : null,
                      ),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    )
                  : Center(
                      child: Text("Không có thông tin danh sách câu trả lời."),
                    ))),
        );
        break;
      case "T":
        return Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    height: 50,
                    child: Obx(
                          () => TextFormField(
                        controller: item.value.textValueController,
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        maxLines: 2,
                        decoration: InputDecoration(
                          counterText: "",
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        enabled: !work.locked ? true : false,
                        onChanged: (String content) async {
                          await new Future.delayed(
                              new Duration(milliseconds: 50), () async {
                            try {
                              item.value.textValue = content;
                              await controller
                                  .updateData(work: work, item: item.value);
                            }catch(ex){
                              item.value.textController.clear();
                              controller.alert(content: ex.toString());
                            }
                          });
                        },
                      ),
                    ))));
        break;
      default:
        return Expanded(
          flex: 1,
          child: Center(),
        );
    }
  }
}
