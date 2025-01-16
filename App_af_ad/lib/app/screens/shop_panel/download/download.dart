import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syngentaaudit/app/components/base_gradient_button.dart';

import 'download_controller.dart';
import 'element/download_item.dart';

class DownloadView extends GetView<DownloadController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx((state) => Container(
        width: size.width,
        child: Column(
          children: [
            Expanded(
                child: ScrollablePositionedList.builder(
              scrollDirection: Axis.vertical,
              itemScrollController: controller.scrollController,
              itemCount: controller.lstDownload.length,
              itemBuilder: (context, index) {
                return DownloadItem(
                  size: size,
                  modle: controller.lstDownload[index],
                  index: index + 1,
                );
              },
            )),
            // Expanded(
            //     child: ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: controller.lstDownload.length,
            //   itemBuilder: (context, index) {
            //     return DownloadItem(
            //       size: size,
            //       modle: controller.lstDownload[index],
            //       index: index + 1,
            //     );
            //   },
            // )),
            Container(
              height: 50,
              margin: EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: BaseGradientButton(
                onPressed: () {
                  controller.download();
                },
                text: 'Tải dữ liệu',
              ),
            )
          ],
        )));
  }
}
