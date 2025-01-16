import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/components/base_gradient_button.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';

import 'upload_controller.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

class UploadView extends GetView<UploadController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (controller.dataUpload != null &&
                            controller.dataUpload.length > 0)
                        ? controller.dataUpload.length
                        : 0,
                    itemBuilder: (context, index) {
                      return Container(
                        width: size.width,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            elevation: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                !controller.dataUpload[index].groupBy
                                        .isNullOrWhiteSpace()
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.only(
                                              topLeft: const Radius.circular(5),
                                              topRight:
                                                  const Radius.circular(5)),
                                          shape: BoxShape.rectangle,
                                          color: AppStyle.primary,
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        width: size.width,
                                        height: 30,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Thời gian: ' +
                                                DateTimes.dateToString(
                                                    datetime: controller
                                                        .dataUpload[index]
                                                        .workDate),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))
                                    : SizedBox(),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'ShopId: ${controller.dataUpload[index].shopId} - ShopName: ${controller.dataUpload[index].shopName}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    controller.getListKPI(controller
                                        .dataUpload[index].itemDetail),
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                          'Tổng hình: ' +
                                              controller
                                                  .dataUpload[index].totalPhoto
                                                  .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                            'Upload TC: ' +
                                                controller.dataUpload[index]
                                                    .totalPhotoSuccess
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: const Radius.circular(5),
                                        bottomRight: const Radius.circular(5)),
                                    shape: BoxShape.rectangle,
                                    color: Colors.blue,
                                  ),
                                  padding: EdgeInsets.all(5),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                          'Tổng audio: ' +
                                              controller
                                                  .dataUpload[index].totalAudio
                                                  .toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )),
                                      Expanded(
                                          child: Container(
                                        child: Text(
                                            'Upload TC: ' +
                                                controller.dataUpload[index]
                                                    .totalAudioSuccess
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      )),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      );
                    }),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.fromLTRB(5, 10, 5, 20),
                child: BaseGradientButton(
                  onPressed: () {
                    controller.upload();
                  },
                  text: 'Upload dữ liệu',
                ),
              )
            ],
          ),
        ));
  }
}
