
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synchronized/synchronized.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/context/photoContext.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/models/PromotionResultModel.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';

class KPIPromotionController extends BaseController {
  RxList<Rx<PromotionResultModel>> lstPosm = <Rx<PromotionResultModel>>[].obs;
  ImagePicker picker = ImagePicker();
  Lock lock = new Lock(reentrant: true);
  bool isCapture = true;

  Future<void> getPromotionResult(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    await showProgess();
    List<PromotionResultModel> lstTemp = await AuditContext.getPromotionResult(work);
    print('listpromotion');
    print(lstTemp.map((e) => e.toJson().toString()));
    List<PhotoInfo> photoTemp =
    await PhotoContext.getPhotoKPIs(workId: work.rowId, kpiId: kpi.id);
    if (lstTemp != null && lstTemp.length != 0) {
      for (PromotionResultModel item in lstTemp) {
        item.textController = TextEditingController();
        if (ExString(item.value1.toString()).isNullOrWhiteSpace()) {
          item.textController.text = "";
        } else {
          item.textController.text = item.value1.toString();
        }

        item.lstPhoto = new List<PhotoInfo>.empty(growable: true);
        if (photoTemp != null && photoTemp.length != 0) {
          for (PhotoInfo photo in photoTemp) {
            if (photo.kpiId == kpi.id && photo.itemId == item.promotionId) {
              item.lstPhoto.add(photo);
            }
          }
        }
      }
      for (PromotionResultModel item in lstTemp) {
        lstPosm.add(item.obs);
      }
      await hideProgess();
    } else {
      await hideProgess();
    }
  }

  Future<void> getUpdateDataPosm(
      {WorkResultInfo work,
        PromotionResultModel item,
        bool checkYes,
        bool checkNo}) async {
    if (checkYes != null) {
      if (checkYes) {
        item.value = 1;
      } else {
        item.value = null;
      }
    }
    if (checkNo != null) {
      if (checkNo) {
        item.value = 0;
        item.value1 = null;
        item.textController.clear();
      } else {
        item.value = null;
      }
    }
    await updateDataPosm(work: work, item: item);
  }

  Future<void> getUpdateDataPosm1(
      {WorkResultInfo work,
        PromotionResultModel item,
        bool checkYes,
        bool checkNo}) async {
    if (checkYes != null) {
      if (checkYes) {
        item.value1 = 1;
      } else {
        item.value1 = null;
      }
    }
    if (checkNo != null) {
      if (checkNo) {
        item.value1 = 0;
      } else {
        item.value1 = null;
      }
    }
    await updateDataPosm(work: work, item: item);
  }

  Future<void> updateDataPosm(
      {WorkResultInfo work, PromotionResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.setDataPromotion(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<PromotionResultModel> temp = lstPosm.firstWhere(
                  (Rx<PromotionResultModel> element) =>
              element.value.promotionId == item.promotionId);
          temp.value = item;
          lstPosm.refresh();
        } else {
          alert(content: value);
        }
      });
    });
  }

  Future<void> startCameraKPIs(
      {WorkResultInfo work,
        ShopInfo shop,
        MasterInfo kpi,
        PromotionResultModel itemP}) async {
    await showProgess();
    if (isCapture) {
      isCapture = false;
      if (work.auditResult == 0) {
        isCapture = true;
        confirmOK("Lỗi trạng thái cửa hàng. Vui lòng chọn lại.", () {
          Get.back(result: "result");
          return false;
        });
        return;
      }

      if (work != null && !work.locked) {
        // ignore: deprecated_member_use
        PickedFile pickedFile = await picker.getImage(
            source: ImageSource.camera, maxWidth: 1280, imageQuality: 90);
        if (pickedFile != null &&
            !ExString(pickedFile.path).isNullOrWhiteSpace()) {
          File file = await FileUtils.createImage();

          if (itemP != null) {
            await saveImageKPI(
                work: work,
                shop: shop,
                kpiId: kpi.id,
                itemId: itemP.promotionId,
                file: file,
                pickedFile: pickedFile)
                .then((String value) async {
              if (!ExString(value).isNullOrWhiteSpace()) {
                alert(content: value);
              } else {
                if (lstPhoto != null && lstPhoto.length != 0) {
                  itemP.lstPhoto = lstPhoto;
                }
                Rx<PromotionResultModel> temp = lstPosm.firstWhere(
                        (Rx<PromotionResultModel> element) =>
                    element.value.promotionId == itemP.promotionId);
                temp.value = itemP;
                lstPosm.refresh();
              }
            });
          }

          isCapture = true;
          await hideProgess();
        } else {
          isCapture = true;
          await hideProgess();
          //alert(content: "Lỗi hình vui lòng chụp lại.");
        }
      }
    } else {
      await hideProgess();
    }
  }

  onBackPress() {
    Get.back(result: "ok");
  }
}
