

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/components/base_view_photo_dialog.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/OsaResultModel.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/screens/kpis/osaComponents/searchSKU.dart';
import 'package:syngentaaudit/app/screens/kpis/surveyComponents/albumImages.dart';

import 'kpi_controller.dart';

class Osa extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OsaState();
  }
}

class OsaState extends State<Osa> {
  KPIController controller;
  ShopInfo shop;
  WorkResultInfo work;
  MasterInfo kpi;
  bool ISOOS = false;

  @override
  void initState() {
    controller = Get.find();
    shop = Get.arguments[0];
    work = Get.arguments[1];
    kpi = Get.arguments[2];
    ISOOS = Get.arguments[3];
    controller.work = work.obs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getDataOsa(shop, work, kpi);
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
          body: body(),


        ));
  }
  Widget body(){
   return Container(
     height: Utility.getHeightScreen(context),
     width: Utility.getWidthScreen(context),
     padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
     color: const Color(0xFFE5E5E5),
     child: Column(
       children: [
         SizedBox(height: 5,),
         SearchSKU(controller: controller,shop: shop,),
         osaList(),

         Container(
             margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
             padding: EdgeInsets.only(top: 5),
             child: Row(children: [
                     TextButton(
                       style: ButtonStyle(
                         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                         backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                       ),
                       onPressed: () {showsummary(); },
                       child: Text('Tổng hợp số mặt theo nhãn hàng'),
                     ),
                     SizedBox(width: 10,),
               Visibility( visible: ISOOS && !work.locked, child: TextButton(
                               style: ButtonStyle(
                                 foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                 backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                               ),
                               onPressed: () {controller.setOOSAll(shop, work, kpi); },
                               child: Text('Điền 0 tất cả'),)
                             ),

                   ],)
                   ),





       ],
     ),
   );
  }

  Future<void> showsummary() async {
    await controller.getDataOsaSummary(shop, work, kpi);
    final List<int> colorCodes = <int>[500, 10];
    print("-------------------Show image--------------");
    Size size = Get.mediaQuery.size;
    Get.defaultDialog(
        titleStyle: TextStyle(color: AppStyle.primaryDart),
        title: 'Tổng hợp (' + controller.lstOsaSummary[0].value.checkprice.toString() + ' Facing)' ,
        content: Container(
          width: size.width,
          height: size.height /2,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: controller.lstOsaSummary.length,
              itemBuilder: (BuildContext context, int index) {
                return
                  Container(
                  height: controller.lstOsaSummary[index].value.showKeyBrand ==1?52: 30,
                  //color: Colors.amber[colorCodes[index%2]],
                  child: Column(
                    children: [
                      controller.lstOsaSummary[index].value.showKeyBrand ==1?
                      Text('${controller.lstOsaSummary[index].value.keyBrand}',style: TextStyle(color: Colors.blue),textAlign:TextAlign.left,)
                          :Center(),
                      Container(
                        //color: Colors.amber[colorCodes[index%2]],
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            color: Colors.amber[colorCodes[index%2]],
                        ),
                        child:  Row(
                          children: [
                            Expanded(
                              child: Text((index+1).toString()+'/' + controller.lstOsaSummary.length.toString()+'. '+'${controller.lstOsaSummary[index].value.segment}'),
                              flex: 4,
                            ),
                            Expanded(
                              child: Text('${controller.lstOsaSummary[index].value.osaValue}'),
                              flex: 1,
                            ),
                            // Flexible(
                            //   flex: 2,
                            //   child: Text('${controller.lstOsaSummary[index].segment}'),
                            // ),
                            // Flexible(
                            //   flex: 1,
                            //   child: Text('${controller.lstOsaSummary[index].osaValue}'),
                            // ),

                          ],
                        ),
                      ),
                    ],

                  ) //Center(child: Text('${controller.lstOsaSummary[index].segment}' +'--'+ '${controller.lstOsaSummary[index].osaValue}')),
                );
              }
          ),
        ),
        radius: 10.0);
  }

  Widget osaList() {
    return
        Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                padding: EdgeInsets.only(top: 5),
                child: Obx(
                      () => MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: controller.lstOsaFilter != null &&
                          controller.lstOsaFilter.length != 0
                          ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: controller.lstOsaFilter.length,
                          itemBuilder: (BuildContext context, int index) {
                            return itemListView(
                                context, controller.lstOsaFilter[index], index,controller.lstOsaFilter.length);
                          })
                          : Center()),
                ))
    );
  }

  Widget itemListView(
      BuildContext context, Rx<OsaResultModel> item, int index,int total) {
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
            Visibility(
                visible: item.value.showKeyBrand == 1
                    ? true
                    : false,
                child: Container(
                  height: 70,
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
                  color: const Color(0xFFE5E5E5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(children: [
                            SizedBox(
                              width: 20,
                              child: VerticalDivider(
                                thickness: 5,
                                endIndent: 5,
                                indent: 5,
                                color: const Color(0xFF32B768),
                              ),
                            ),
                            Container(
                              width: item.value.keyBrand != null && !item.value.keyBrand.contains("SURVEY") ?120:120,
                              child: Text(
                                !ExString(item.value.keyBrand)
                                        .isNullOrWhiteSpace()
                                    ? item.value.keyBrand //+ ";s:" + item.value.segment
                                    : "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ])),
                      Visibility(
                          visible: !ExString(item.value.keyBrand)
                                      .isNullOrWhiteSpace() //&& !item.value.keyBrand.contains("SURVEY")
                              ? true
                              : false,
                          child: Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        width: 80,
                                        child: TextButton.icon(
                                            onPressed: !work.locked
                                                ? () {
                                                    controller.startCameraKPIs(
                                                        work: work,
                                                        shop: shop,
                                                        kpi: kpi,
                                                        itemOsa: item.value);
                                                  }
                                                : null,
                                            style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                padding: EdgeInsets.all(20),
                                                backgroundColor:
                                                    const Color(0xFFF6FFED)),
                                            icon: Icon(Icons.camera_alt_rounded,
                                                color: const Color(0xFF32B768),
                                                size: 20),
                                            label: Text("")),
                                      )),
                                  SizedBox(
                                    width: 80,
                                    child: TextButton.icon(
                                        onPressed: () => Get.to(AlbumImages(
                                            photos: item.value.lstPhoto)),
                                        style: TextButton.styleFrom(
                                            padding: EdgeInsets.all(20),
                                            primary: const Color(0xFFA6A6A6),
                                            backgroundColor:
                                                const Color(0xFFD9D9D9)),
                                        icon: Icon(
                                          Icons.photo,
                                          size: 20,
                                        ),
                                        label: item.value.lstPhoto != null &&
                                                item.value.lstPhoto.length != 0
                                            ? Text(
                                                '${item.value.lstPhoto.length}')
                                            : Text("")),
                                  )
                                ],
                              )))
                    ],
                  ),
                )),
            if(item.value.showKeyBrand == 1)
              ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 50),
                  child: TextFormField(
                    initialValue: item.value.comment,
                    enabled: !work.locked ? true : false,
                    onChanged: (value) async {
                      await new Future.delayed(new Duration(milliseconds: 50),
                              () async {
                            try {
                              item.value.comment = value;
                              await controller.updateDataOsa(
                                  work: work, item: item.value);
                            } catch (ex) {}
                          });
                    },
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: "Ghi chú"),
                  )),
            Container(
                padding: EdgeInsets.all(2),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Text(
                            !ExString(item.value.productName)
                                    .isNullOrWhiteSpace()
                                ? (index+1).toString()+"/" +total.toString() +". "+ item.value.productName + "/"+ item.value.showKeyBrand.toString()
                                : "SKU ko có tên.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            if (!ExString(item.value.productName)
                                .isNullOrWhiteSpace()) {
                              if (!ExString(item.value.photo)
                                  .isNullOrWhiteSpace()) {
                                BaseViewPhotoDialog.show(
                                    item.value.photo, context);
                              }
                            }
                          },
                        )),
                    Visibility(
                        visible: !ExString(item.value.segment)
                                    .isNullOrWhiteSpace() &&
                                item.value.segment.contains("SURVEY")
                            /*&&
                                item.value.productId != controller.itemMaxSurvey*/
                            ? true
                            : false,
                        child: Expanded(
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
                                          value: item.value.osaValue != null &&
                                                  item.value.osaValue == 1
                                              ? true
                                              : false,
                                          onChanged: !work.locked
                                              ? (bool check) {
                                                  if (!work.locked) {
                                                    controller.getUpdateDataOsa(
                                                        item: item.value,
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
                                              style: TextStyle(fontSize: 12)),
                                          value: item.value.osaValue != null &&
                                                  item.value.osaValue == 0
                                              ? true
                                              : false,
                                          onChanged: !work.locked
                                              ? (bool check) {
                                                  if (!work.locked) {
                                                    controller.getUpdateDataOsa(
                                                        item: item.value,
                                                        checkNo: check,
                                                        work: work);
                                                  }
                                                }
                                              : null,
                                          controlAffinity:
                                              ListTileControlAffinity
                                                  .leading))))
                            ],
                          ),
                        ))
                  ],
                )),
            Visibility(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50),
                child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Center(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('Số mặt thực tế: '),
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
                                enabled: !work.locked ? true : false,
                                onChanged: (String content) {
                                  Future.delayed(
                                      new Duration(milliseconds: 500),
                                      () async {
                                    try {
                                      int temp = !ExString(content)
                                              .isNullOrWhiteSpace()
                                          ? int.parse(content)
                                          : null;
                                      item.value.osaValue = temp;
                                      await controller
                                          .updateDataOsa(
                                              work: work, item: item.value)
                                          .then((value) => FocusScope.of(
                                                  context)
                                              .requestFocus(new FocusNode()));
                                    } catch (e) {
                                      item.value.osaValue = null;
                                      await controller
                                          .updateDataOsa(
                                              work: work, item: item.value)
                                          .then((value) => FocusScope.of(
                                                  context)
                                              .requestFocus(new FocusNode()));
                                    }
                                  });
                                },
                              ),
                            )),
                      ],
                    )),
              ),
              visible: !ExString(item.value.segment).isNullOrWhiteSpace() &&
                      !item.value.segment.contains("SURVEY")
                  ? true
                  : false,
            ),
            // if(item.value.showKeyBrand == 1)
            // ConstrainedBox(
            //     constraints: BoxConstraints(minHeight: 50),
            //     child: TextFormField(
            //       initialValue: item.value.comment,
            //       enabled: !work.locked ? true : false,
            //       onChanged: (value) async {
            //         await new Future.delayed(new Duration(milliseconds: 50),
            //             () async {
            //           try {
            //             item.value.comment = value;
            //             await controller.updateDataOsa(
            //                 work: work, item: item.value);
            //           } catch (ex) {}
            //         });
            //       },
            //       decoration: new InputDecoration(
            //           border: OutlineInputBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(10))),
            //           contentPadding: EdgeInsets.only(
            //               left: 15, bottom: 11, top: 11, right: 15),
            //           hintText: "Ghi chú"),
            //     )),
            Visibility(
                visible: !ExString(item.value.segment).isNullOrWhiteSpace() &&
                        item.value.segment.contains("SURVEY")  &&
                        item.value.productId == controller.itemMaxSurvey
                    ? true
                    : false,
                child: Container(
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
                                            controller.startCameraOsa(
                                                work, shop, kpi, item.value);
                                          }
                                        : null,
                                    style: TextButton.styleFrom(
                                        primary: Colors.white,
                                        padding: EdgeInsets.all(20),
                                        backgroundColor:
                                            const Color(0xFFF6FFED)),
                                    icon: Icon(Icons.camera_alt_rounded,
                                        color: const Color(0xFF32B768),
                                        size: 30),
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
                    )))
          ],
        ),
      ),
    );
  }
}
