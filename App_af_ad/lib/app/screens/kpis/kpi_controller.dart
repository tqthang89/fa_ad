import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synchronized/synchronized.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/ProductInfo.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/context/photoContext.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/OsaResultModel.dart';
import 'package:syngentaaudit/app/models/PosmResultModel.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/models/SurveyDetailResultModel.dart';
import 'package:syngentaaudit/app/models/SurveyResultModel.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

class KPIController extends BaseController {
  RxList<Rx<SurveyResultModel>> lst = <Rx<SurveyResultModel>>[].obs;
  RxList<Rx<PosmResultModel>> lstPosm = <Rx<PosmResultModel>>[].obs;
  RxList<Rx<OsaResultModel>> lstOsa = <Rx<OsaResultModel>>[].obs;
  RxList<Rx<OsaResultModel>> lstOsaFilter = <Rx<OsaResultModel>>[].obs;
  RxList<Rx<OsaResultModel>> lstOsaSummary = <Rx<OsaResultModel>>[].obs;
  //List<OsaResultModel> lstOsaSummary;
  bool isCapture = true;
  RxBool isOOS = false.obs;
  ImagePicker picker = ImagePicker();
  Lock lock = new Lock(reentrant: true);
  int itemMaxSurvey = 0;
  RxDouble searchHeight = 60.0.obs;
  RxBool eSearchDetail = false.obs;
  String selectProductOSA = "";
  TextEditingController selectProductOSATEController = TextEditingController();
  RxList<String> lstBrandOSA = <String>[].obs;
  RxString selectKeyBrandOSA = "".obs;
  RxBool eNotDoneOSA = false.obs;

  Future<void> getData(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    String groups = "";
    await showProgess();
    List<SurveyAnswerInfo> lstAns = await AuditContext.getSurveyAnswer(kpi.id);
    List<SurveyResultModel> lstTemp =
        await AuditContext.getSurveyResult(work, kpi.id);
    List<PhotoInfo> photoTemp =
        await PhotoContext.getPhotoKPIs(workId: work.rowId, kpiId: kpi.id);
    if (lst.length != 0) {
      lst.clear();
    }
    if (lstTemp != null && lstTemp.length != 0) {
      for (SurveyResultModel item in lstTemp) {
        item.textController = TextEditingController();
        item.textValueController = TextEditingController();
        if (ExString(item.value.toString()).isNullOrWhiteSpace()) {
          item.textController.text = "";
        } else {
          item.textController.text = item.value.toString();
        }
        if (ExString(item.textValue.toString()).isNullOrWhiteSpace()) {
          item.textValueController.text = "";
        } else {
          item.textValueController.text = item.textValue.toString();
        }
        item.lstPhoto = <PhotoInfo>[];
        if (photoTemp != null && photoTemp.length != 0) {
          for (PhotoInfo photo in photoTemp) {
            if (photo.itemId == item.surveyId) {
              item.lstPhoto.add(photo);
            }
          }
        }
        if (!ExString(item.groups).isNullOrWhiteSpace()) {
          if (item.groups != groups) {
            groups = item.groups;
          } else {
            item.groups = "";
          }
        }
        List<SurveyDetailResultModel> lstDetailTemp =
            await AuditContext.getSurveyDetail(work, item.surveyId);
        item.lstDetail =
            new RxList<SurveyDetailResultModel>.empty(growable: true);
        if (lstDetailTemp != null && lstDetailTemp.length != 0) {
          for (SurveyDetailResultModel detail in lstDetailTemp) {
            detail.textController = TextEditingController();
            detail.textValueController = TextEditingController();
            if (ExString(detail.value.toString()).isNullOrWhiteSpace()) {
              detail.textController.text = "";
            } else {
              detail.textController.text = detail.value.toString();
            }
          }
        }
        item.lstDetail.addAll(lstDetailTemp);
      }
      if (lstAns != null && lstAns.length != 0) {
        for (SurveyResultModel item in lstTemp) {
          item.lstAns = <SurveyAnswerInfo>[];
          for (SurveyAnswerInfo an in lstAns) {
            if (an.surveyId == item.surveyId) {
              item.lstAns.add(an);
            }
          }
          if (item.type == "S") {
            if (!ExString(item.value.toString()).isNullOrWhiteSpace()) {
              if (item.lstAns != null && item.lstAns.length != 0) {
                for (SurveyAnswerInfo an in item.lstAns) {
                  if (an.id == item.value) {
                    item.itemSelected = an;
                    break;
                  }
                }
              } else {}
            } else {
              if (item.lstAns != null && item.lstAns.length != 0) {
                item.itemSelected = item.lstAns[0];
              } else {}
            }
          }
        }
      }
      for (SurveyResultModel item in lstTemp) {
        lst.add(item.obs);
      }
      await hideProgess();
    } else {
      await hideProgess();
    }
  }

  Future<void> getUpdateData(
      {WorkResultInfo work,
      SurveyResultModel item,
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
      } else {
        item.value = null;
      }
    }
    await updateData(work: work, item: item).then((value)(
        item.type == "R" && item.value != 1
            ? await deteleDataDetail(work: work, item: item)
            : null));
  }

  Future<void> updateData({WorkResultInfo work, SurveyResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.setData(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<SurveyResultModel> temp = lst.firstWhere(
              (Rx<SurveyResultModel> element) =>
                  element.value.surveyId == item.surveyId);
          temp.value = item;
          lst.refresh();
        } else {
          alert(content: value);
        }
      });
    });
  }

  Future<void> updateDataDetail(
      {WorkResultInfo work, SurveyDetailResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.setDataDetail(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<SurveyResultModel> temp = lst.firstWhere(
              (Rx<SurveyResultModel> element) =>
                  element.value.surveyId == item.surveyId);

          // ignore: unused_local_variable
          SurveyDetailResultModel tempDetail = temp.value.lstDetail.firstWhere(
              (SurveyDetailResultModel element) => element.sdId == item.sdId);
          tempDetail = item;
          lst.refresh();
        } else {
          alert(content: value);
        }
      });
    });
  }

  Future<void> deteleDataDetail(
      {WorkResultInfo work, SurveyResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.deleteDataDetail(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<SurveyResultModel> temp = lst.firstWhere(
              (Rx<SurveyResultModel> element) =>
                  element.value.surveyId == item.surveyId);
          if (temp.value.lstDetail != null &&
              temp.value.lstDetail.length != 0) {
            for (SurveyDetailResultModel detail in temp.value.lstDetail) {
              detail.value = null;
            }
            lst.refresh();
          }
        }
      });
    });
  }

  Future<void> startCamera(WorkResultInfo work, ShopInfo shop, MasterInfo kpi,
      SurveyResultModel item) async {
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
          await saveImageKPI(
                  work: work,
                  shop: shop,
                  kpiId: kpi.id,
                  itemId: item.surveyId,
                  file: file,
                  pickedFile: pickedFile)
              .then((String value) async {
            if (!ExString(value).isNullOrWhiteSpace()) {
              alert(content: value);
            } else {
              if (lstPhoto != null && lstPhoto.length != 0) {
                item.lstPhoto = lstPhoto;
              }
              Rx<SurveyResultModel> temp = lst.firstWhere(
                  (Rx<SurveyResultModel> element) =>
                      element.value.surveyId == item.surveyId);
              temp.value = item;
              lst.refresh();
            }
          });
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

  Future<void> getDataPosm(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    await showProgess();
    List<MasterInfo> lstAns =
        await AuditContext.getMasterList('${kpi.code}OPTION');
    List<PosmResultModel> lstTemp = await AuditContext.getPosmResult(work);
    List<PhotoInfo> photoTemp =
        await PhotoContext.getPhotoKPIs(workId: work.rowId, kpiId: kpi.id);
    if (lstTemp != null && lstTemp.length != 0) {
      for (PosmResultModel item in lstTemp) {
        item.textController = TextEditingController();
        if (ExString(item.quantity.toString()).isNullOrWhiteSpace()) {
          item.textController.text = "";
        } else {
          item.textController.text = item.quantity.toString();
        }

        item.lstAns = new List<MasterInfo>.empty(growable: true);
        if (lstAns != null && lstAns.length != 0) {
          item.lstAns.addAll(lstAns);
          if (item.status != null) {
            for (MasterInfo ans in lstAns) {
              if (ans.id == item.status) {
                item.itemSelected = ans;
              }
            }
          } else {
            item.itemSelected = lstAns[0];
          }
        }

        item.lstPhoto = new List<PhotoInfo>.empty(growable: true);
        if (photoTemp != null && photoTemp.length != 0) {
          for (PhotoInfo photo in photoTemp) {
            if (photo.kpiId == kpi.id && photo.itemId == item.posmId) {
              item.lstPhoto.add(photo);
            }
          }
        }
      }
      for (PosmResultModel item in lstTemp) {
        lstPosm.add(item.obs);
      }
      await hideProgess();
    } else {
      await hideProgess();
    }
  }

  Future<void> getUpdateDataPosm(
      {WorkResultInfo work,
      PosmResultModel item,
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
        item.status = null;
        item.quantity = null;
        item.textController.clear();
        item.itemSelected = item.lstAns[0];
      } else {
        item.value = null;
      }
    }
    await updateDataPosm(work: work, item: item);
  }

  Future<void> updateDataPosm(
      {WorkResultInfo work, PosmResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.setDataPosm(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<PosmResultModel> temp = lstPosm.firstWhere(
              (Rx<PosmResultModel> element) =>
                  element.value.posmId == item.posmId);
          temp.value = item;
          lstPosm.refresh();
        } else {
          alert(content: value);
        }
      });
    });
  }

  Future<void> startCameraPosm(WorkResultInfo work, ShopInfo shop,
      MasterInfo kpi, PosmResultModel item) async {
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
            source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
        if (pickedFile != null &&
            !ExString(pickedFile.path).isNullOrWhiteSpace()) {
          File file = await FileUtils.createImage();
          await saveImageKPI(
                  work: work,
                  shop: shop,
                  kpiId: kpi.id,
                  itemId: item.posmId,
                  file: file,
                  pickedFile: pickedFile)
              .then((String value) async {
            if (!ExString(value).isNullOrWhiteSpace()) {
              alert(content: value);
            } else {
              if (lstPhoto != null && lstPhoto.length != 0) {
                item.lstPhoto = lstPhoto;
              }
              Rx<PosmResultModel> temp = lstPosm.firstWhere(
                  (Rx<PosmResultModel> element) =>
                      element.value.posmId == item.posmId);
              temp.value = item;
              lstPosm.refresh();
            }
          });
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

  Future<void> getDataOsa(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    String keyBrand = "";
    itemMaxSurvey = 0;
    lstBrandOSA.clear();
    await showProgess();
    List<OsaResultModel> lstTemp = await AuditContext.getOsaResult(work, shop);
    List<PhotoInfo> photoTemp =
        await PhotoContext.getPhotoKPIs(workId: work.rowId, kpiId: kpi.id);

    if (lstTemp != null && lstTemp.length != 0) {
      for (OsaResultModel item in lstTemp) {
        item.textController = TextEditingController();
        if (ExString(item.osaValue.toString()).isNullOrWhiteSpace()) {
          item.textController.text = "";
        } else {
          item.textController.text = item.osaValue.toString();
        }

        item.layyer_textController = TextEditingController();
        if (ExString(item.layerValue.toString()).isNullOrWhiteSpace()) {
          item.layyer_textController.text = "";
        } else {
          item.layyer_textController.text = item.layerValue.toString();
        }

        item.foot_textController = TextEditingController();
        if (ExString(item.footValue.toString()).isNullOrWhiteSpace()) {
          item.foot_textController.text = "";
        } else {
          item.foot_textController.text = item.footValue.toString();
        }

        if (!ExString(item.keyBrand).isNullOrWhiteSpace()) {
          if (item.keyBrand != keyBrand) {
            keyBrand = item.keyBrand;
            lstBrandOSA.add(keyBrand);
            item.showKeyBrand = 1;
          } else {
            item.showKeyBrand = 0;
          }
        }

        item.lstPhoto = new List<PhotoInfo>.empty(growable: true);
        if (photoTemp != null && photoTemp.length != 0) {
          for (PhotoInfo photo in photoTemp) {
            if (photo.kpiId == kpi.id && photo.itemId == item.productId) {
              item.lstPhoto.add(photo);
            }
          }
        }
      }
      for (OsaResultModel item in lstTemp) {
        if (!ExString(item.segment).isNullOrWhiteSpace() &&
            item.segment.contains("SURVEY")) {
          itemMaxSurvey++;
        }
        lstOsa.add(item.obs);
      }
      lstBrandOSA.add("Tất cả");
      selectKeyBrandOSA = lstBrandOSA.last.obs;
      lstOsaFilter.value = lstOsa;
      await hideProgess();
    } else {
      await hideProgess();
    }
  }

  Future<void> getDataOsaSummary(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    await showProgess();
    List<OsaResultModel> lstTemp =
        await AuditContext.getOsaResult_Summary(work, shop);
    String keyBrand = "";
    if (lstTemp != null && lstTemp.length != 0) {
      int facingTotal = 0;
      for (OsaResultModel item in lstTemp) {
        if (!ExString(item.keyBrand).isNullOrWhiteSpace()) {
          if (item.keyBrand != keyBrand) {
            keyBrand = item.keyBrand;
            lstBrandOSA.add(keyBrand);
            item.showKeyBrand = 1;
          } else {
            item.showKeyBrand = 0;
          }
          facingTotal = facingTotal + item.osaValue;
        }
      }
      lstTemp[0].checkprice = facingTotal;
      lstOsaSummary = <Rx<OsaResultModel>>[].obs;
      for (OsaResultModel item in lstTemp) {
        lstOsaSummary.add(item.obs);
      }
      //lstOsaSummary = lstTemp.obs;

      // for (OsaResultModel item in lstTemp) {
      //   if (!ExString(item.segment).isNullOrWhiteSpace() && item.segment == "SURVEY") {
      //     itemMaxSurvey++;
      //   }
      //   lstOsaSummary.add(item);
      // }
      await hideProgess();
    } else {
      await hideProgess();
    }

    // if (lstTemp != null && lstTemp.length != 0) {
    //   for (OsaResultModel item in lstTemp) {
    //     lstOsaSummary.add(item.obs);
    //   }
    //
    //   //await hideProgess();
    // } else {
    //   //await hideProgess();
    // }
    //change(value, status: RxStatus.success());
  }

  Future<void> setOOSAll(
      ShopInfo shop, WorkResultInfo work, MasterInfo kpi) async {
    await showProgess();

    await lock.synchronized(() async {
      //List<OsaResultModel> la = new List<OsaResultModel>();
      bool hasUpdate = false;
      for (int i = 0; i < lstOsa.length; i++) {
        Rx<OsaResultModel> item = lstOsa[i];
        if (item.value.osaValue == null) {
          hasUpdate = true;
          item.value.osaValue = 0;
          item.value.textController.text = "0";
          await lock.synchronized(() async {
            await AuditContext.setDataOsa(work, item.value)
                .then((String value) {
              if (ExString(value).isNullOrWhiteSpace()) {
                lstOsa.refresh();
              } else {
                alert(content: value);
              }
            });
          });

          //await updateDataOsa(work:work, item:item.value);
          //item.value.osaValue = 0;
          //la.add(item.value);
        }
      }
      if (hasUpdate == true) {
        lstOsaFilter.value = lstOsa;
        print(lstOsaFilter[20].value.osaValue.toString() +
            "-" +
            lstOsaFilter[20].value.productName);
      }
      // if(la != null && la.length >0)
      //   {
      //     await AuditContext.setAllDataOsa(work, la).then((value) => {
      //        lstOsa.refresh(),
      //         searchDataOsa()
      //     });
      //   }
    });

    await hideProgess();
  }

  Future<void> getUpdateDataOsa(
      {WorkResultInfo work,
      OsaResultModel item,
      bool checkYes,
      bool checkNo}) async {
    if (checkYes != null) {
      if (checkYes) {
        item.osaValue = 1;
      } else {
        item.osaValue = null;
      }
    }
    if (checkNo != null) {
      if (checkNo) {
        item.osaValue = 0;
      } else {
        item.osaValue = null;
      }
    }
    await updateDataOsa(work: work, item: item);
  }

  Future<void> updateDataOsa({WorkResultInfo work, OsaResultModel item}) async {
    await lock.synchronized(() async {
      await AuditContext.setDataOsa(work, item).then((String value) {
        if (ExString(value).isNullOrWhiteSpace()) {
          Rx<OsaResultModel> temp = lstOsa.firstWhere(
              (Rx<OsaResultModel> element) =>
                  element.value.productId == item.productId);
          temp.value = item;
          lstOsa.refresh();
          searchDataOsa();
        } else {
          alert(content: value);
        }
      });
    });
  }

  Future<void> startCameraOsa(WorkResultInfo work, ShopInfo shop,
      MasterInfo kpi, OsaResultModel item) async {
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
            source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
        if (pickedFile != null &&
            !ExString(pickedFile.path).isNullOrWhiteSpace()) {
          File file = await FileUtils.createImage();
          await saveImageKPI(
                  work: work,
                  shop: shop,
                  kpiId: kpi.id,
                  itemId: item.productId,
                  file: file,
                  pickedFile: pickedFile)
              .then((String value) async {
            if (!ExString(value).isNullOrWhiteSpace()) {
              alert(content: value);
            } else {
              if (lstPhoto != null && lstPhoto.length != 0) {
                item.lstPhoto = lstPhoto;
              }
              Rx<OsaResultModel> temp = lstOsa.firstWhere(
                  (Rx<OsaResultModel> element) =>
                      element.value.productId == item.productId);
              temp.value = item;
              lstOsa.refresh();
            }
          });
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

  Future<void> startCameraKPIs(
      {WorkResultInfo work,
      ShopInfo shop,
      MasterInfo kpi,
      OsaResultModel itemOsa,
      SurveyResultModel itemSurvey,
      PosmResultModel itemPosm}) async {
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
            source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
        if (pickedFile != null &&
            !ExString(pickedFile.path).isNullOrWhiteSpace()) {
          File file = await FileUtils.createImage();
          if (itemOsa != null) {
            await saveImageKPI(
                    work: work,
                    shop: shop,
                    kpiId: kpi.id,
                    itemId: itemOsa.productId,
                    file: file,
                    pickedFile: pickedFile)
                .then((String value) async {
              if (!ExString(value).isNullOrWhiteSpace()) {
                alert(content: value);
              } else {
                if (lstPhoto != null && lstPhoto.length != 0) {
                  itemOsa.lstPhoto = lstPhoto;
                }
                Rx<OsaResultModel> temp = lstOsa.firstWhere(
                    (Rx<OsaResultModel> element) =>
                        element.value.productId == itemOsa.productId);
                temp.value = itemOsa;
                lstOsa.refresh();
              }
            });
          }
          if (itemSurvey != null) {
            await saveImageKPI(
                    work: work,
                    shop: shop,
                    kpiId: kpi.id,
                    itemId: itemSurvey.surveyId,
                    file: file,
                    pickedFile: pickedFile)
                .then((String value) async {
              if (!ExString(value).isNullOrWhiteSpace()) {
                alert(content: value);
              } else {
                if (lstPhoto != null && lstPhoto.length != 0) {
                  itemSurvey.lstPhoto = lstPhoto;
                }
                Rx<SurveyResultModel> temp = lst.firstWhere(
                    (Rx<SurveyResultModel> element) =>
                        element.value.surveyId == itemSurvey.surveyId);
                temp.value = itemSurvey;
                lst.refresh();
              }
            });
          }
          if (itemPosm != null) {
            await saveImageKPI(
                    work: work,
                    shop: shop,
                    kpiId: kpi.id,
                    itemId: itemPosm.posmId,
                    file: file,
                    pickedFile: pickedFile)
                .then((String value) async {
              if (!ExString(value).isNullOrWhiteSpace()) {
                alert(content: value);
              } else {
                if (lstPhoto != null && lstPhoto.length != 0) {
                  itemPosm.lstPhoto = lstPhoto;
                }
                Rx<PosmResultModel> temp = lstPosm.firstWhere(
                    (Rx<PosmResultModel> element) =>
                        element.value.posmId == itemPosm.posmId);
                temp.value = itemPosm;
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

  Future<void> searchDataOsa() async {
    if (ExString(selectProductOSA).isNullOrWhiteSpace()) {
      lstOsaFilter.value = lstOsa;
      if (!ExString(selectKeyBrandOSA.value).isNullOrWhiteSpace() &&
          selectKeyBrandOSA.value.toLowerCase() != 'tất cả') {
        lstOsaFilter.value = lstOsaFilter
            .where((osa) => osa.value.keyBrand == selectKeyBrandOSA.value)
            .toList();
      }
      if (eNotDoneOSA.value) {
        if(work.value.shopType.endsWith("GT")) {
          lstOsaFilter.value = lstOsaFilter
              .where((osa) =>
              ExString(osa.value.osaValue.toString()).isNullOrWhiteSpace())
              .toList();
        }
        else if(work.value.shopType.endsWith("MT")) {
          lstOsaFilter.value = lstOsaFilter
              .where((osa) =>
              ExString(osa.value.osaValue.toString()).isNullOrWhiteSpace() || (!ExString(osa.value.osaValue.toString()).isNullOrWhiteSpace() && osa.value.osaValue >0 && (ExString(osa.value.layerValue.toString()).isNullOrWhiteSpace() || (!ExString(osa.value.footid.toString()).isNullOrWhiteSpace() && ExString(osa.value.footValue.toString()).isNullOrWhiteSpace()) ) )
                //|| (!ExString(osa.value.osaValue.toString()).isNullOrWhiteSpace() && ExString(osa.value.footValue.toString()).isNullOrWhiteSpace() && osa.value.osaValue >0 && ExString(osa.value.layerValue.toString()).isNullOrWhiteSpace() )
            )
              .toList();
        }
      }
    } else {
      lstOsaFilter.value = lstOsa
          .where((osa) =>
              osa.value.productName.toLowerCase().contains(selectProductOSA, 0))
          .toList();
      if (!ExString(selectKeyBrandOSA.value).isNullOrWhiteSpace() &&
          selectKeyBrandOSA.value.toLowerCase() != 'tất cả') {
        lstOsaFilter.value = lstOsaFilter
            .where((osa) => osa.value.keyBrand == selectKeyBrandOSA.value)
            .toList();
      }
      if (eNotDoneOSA.value) {
        lstOsaFilter.value = lstOsaFilter
            .where((osa) =>
                ExString(osa.value.osaValue.toString()).isNullOrWhiteSpace())
            .toList();
      }
    }
  }

  onBackPress() {
    Get.back(result: "ok");
  }
}
