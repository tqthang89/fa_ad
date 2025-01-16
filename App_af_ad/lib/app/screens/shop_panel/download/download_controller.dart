import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:syngentaaudit/app/base/CoinCollectInfo.dart';
import 'package:syngentaaudit/app/base/EvaluateResultInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/MobileSupportInfo.dart';
import 'package:syngentaaudit/app/base/OsaInfo.dart';
import 'package:syngentaaudit/app/base/PosmInfo.dart';
import 'package:syngentaaudit/app/base/ProductInfo.dart';
import 'package:syngentaaudit/app/base/PromotionInfo.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';
import 'package:syngentaaudit/app/base/SurveyDetailInfo.dart';
import 'package:syngentaaudit/app/base/SurveyInfo.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';

import '../../../base_controller.dart';
import 'data/DownloadModle.dart';

class DownloadController extends BaseController {
  RxList<DownloadModle> lstDownload;
  bool isDownload = false;
  var db = new DatabaseHelper();
  ItemScrollController scrollController = ItemScrollController();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> download() async {
    if (isDownload) {
      alert(content: 'Đang tải dữ liệu vui lòng đợi !');
      return;
    }
    if (!await Utility.isInternetConnected()) {
      alert(content: 'Vui lòng kiểm tra lại kết nối Internet !');
      return;
    }
    init();
    HttpResponseMessage response = new HttpResponseMessage();
    isDownload = true;
    Fluttertoast.showToast(
        msg: "Bắt đầu tải dữ liệu...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[300],
        textColor: Colors.white,
        fontSize: 15.0);
    try {
      for (DownloadModle modle in lstDownload) {
        modle.status = "Download";
        Map<String, String> params = new Map();
        params["FUNCTION"] = modle.function;
        if (modle.function == 'DEVICE') {
          try {
            params["FUNCTION"] = "DEVICE";
            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            if (Platform.isAndroid) {
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              params["Model"] = androidInfo.model;
              params["Release"] = androidInfo.version.release;
              params["IMEI"] = androidInfo.androidId;
            } else {
              IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
              params["Model"] = iosInfo.utsname.machine;
              params["Release"] = iosInfo.systemVersion;
              params["IMEI"] = iosInfo.identifierForVendor;
            }
          } catch (ex) {
            ex.toString();
          }
        }
        modle.startTime = DateTime.now();
        response = await HttpUtils.post(url: Urls.DOWNLOAD, body: params);
        modle.endTime = DateTime.now();
        print('Download');
        print(response.statusCode.toString());
        print(response.content.toString());
        change(null, status: RxStatus.success());
        scrollController.scrollTo(
            index: modle.id, duration: Duration(seconds: 2));
        if (response.statusCode == 200) {
          switch (modle.function) {
            case 'EVALUATEKPI':
              await db.deleteAll(TableNames.evaluateResult);
              try {
                List<EvaluateResultInfo> _listevaluate =
                    (response.content as List)
                        .map((i) => EvaluateResultInfo.fromJson(i))
                        .toList();
                if (_listevaluate != null && _listevaluate.length > 0) {
                  modle.totalRawDownload = _listevaluate.length;
                  for (EvaluateResultInfo evaluate in _listevaluate) {
                    int raw =
                        await db.insertRow(TableNames.evaluateResult, evaluate);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'COINCOLLECT':
              await db.deleteAll(TableNames.coincollect);
              try {
                List<CoinCollectInfo> _listCoins = (response.content as List)
                    .map((i) => CoinCollectInfo.fromJson(i))
                    .toList();
                if (_listCoins != null && _listCoins.length > 0) {
                  modle.totalRawDownload = _listCoins.length;
                  for (CoinCollectInfo coin in _listCoins) {
                    int raw = await db.insertRow(TableNames.coincollect, coin);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'SHOPS':
              await db.deleteAll(TableNames.shop);
              try {
                List<ShopInfo> _listShop = (response.content as List)
                    .map((i) => ShopInfo.fromJson(i))
                    .toList();
                if (_listShop != null && _listShop.length > 0) {
                  modle.totalRawDownload = _listShop.length;
                  for (ShopInfo shop in _listShop) {
                    int raw = await db.insertRow(TableNames.shop, shop);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'MASTERDATA':
              await db.deleteAll(TableNames.masterList);
              try {
                List<MasterInfo> _listmaster = (response.content as List)
                    .map((i) => MasterInfo.fromJson(i))
                    .toList();
                if (_listmaster != null && _listmaster.length > 0) {
                  modle.totalRawDownload = _listmaster.length;
                  for (MasterInfo master in _listmaster) {
                    int raw = await db.insertRow(TableNames.masterList, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'SUPPORT':
              try {
                List<MobileSupportInfo> _listsupport =
                    (response.content as List)
                        .map((i) => MobileSupportInfo.fromJson(i))
                        .toList();
                if (_listsupport != null && _listsupport.length > 0) {
                  modle.totalRawDownload = _listsupport.length;
                  for (MobileSupportInfo support in _listsupport) {
                    await db.execute(support.queryString);
                  }
                }
                modle.totalRawInsert = 1;
                modle.totalRawDownload = 1;
                modle.status = "Success";
                change(null, status: RxStatus.success());
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'DEVICE':
              modle.totalRawInsert = 1;
              modle.totalRawDownload = 1;
              modle.status = "Success";
              change(null, status: RxStatus.success());
              break;
            case 'KPISURVEY':
              await db.deleteAll(TableNames.kpiSurvey);
              try {
                List<SurveyInfo> _lisSurvey = (response.content as List)
                    .map((i) => SurveyInfo.fromJson(i))
                    .toList();
                if (_lisSurvey != null && _lisSurvey.length > 0) {
                  modle.totalRawDownload = _lisSurvey.length;
                  for (SurveyInfo master in _lisSurvey) {
                    int raw = await db.insertRow(TableNames.kpiSurvey, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'KPISURVEYDETAIL':
              await db.deleteAll(TableNames.kpiSurveyDetail);
              try {
                List<SurveyDetailInfo> _lisSurveyDetail =
                    (response.content as List)
                        .map((i) => SurveyDetailInfo.fromJson(i))
                        .toList();
                if (_lisSurveyDetail != null && _lisSurveyDetail.length > 0) {
                  modle.totalRawDownload = _lisSurveyDetail.length;
                  for (SurveyDetailInfo master in _lisSurveyDetail) {
                    int raw =
                        await db.insertRow(TableNames.kpiSurveyDetail, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'KPISURVEYANSWER':
              await db.deleteAll(TableNames.kpiSurveyAnswer);
              try {
                List<SurveyAnswerInfo> _lisSurveyAnswer =
                    (response.content as List)
                        .map((i) => SurveyAnswerInfo.fromJson(i))
                        .toList();
                if (_lisSurveyAnswer != null && _lisSurveyAnswer.length > 0) {
                  modle.totalRawDownload = _lisSurveyAnswer.length;
                  for (SurveyAnswerInfo master in _lisSurveyAnswer) {
                    int raw =
                        await db.insertRow(TableNames.kpiSurveyAnswer, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'KPIOSA':
              await db.deleteAll(TableNames.kpiOSA);
              try {
                List<OsaInfo> _lisOsa = (response.content as List)
                    .map((i) => OsaInfo.fromJson(i))
                    .toList();
                if (_lisOsa != null && _lisOsa.length > 0) {
                  modle.totalRawDownload = _lisOsa.length;
                  for (OsaInfo master in _lisOsa) {
                    int raw = await db.insertRow(TableNames.kpiOSA, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'PRODUCTS':
              await db.deleteAll(TableNames.product);
              try {
                List<ProductInfo> _lisProduct = (response.content as List)
                    .map((i) => ProductInfo.fromJson(i))
                    .toList();
                if (_lisProduct != null && _lisProduct.length > 0) {
                  modle.totalRawDownload = _lisProduct.length;
                  for (ProductInfo master in _lisProduct) {
                    int raw = await db.insertRow(TableNames.product, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'KPIPROMOTION':
              await db.deleteAll(TableNames.kpiPromotion);
              try {
                List<PromotionInfo> _lisProduct = (response.content as List)
                    .map((i) => PromotionInfo.fromJson(i))
                    .toList();
                if (_lisProduct != null && _lisProduct.length > 0) {
                  modle.totalRawDownload = _lisProduct.length;
                  for (PromotionInfo master in _lisProduct) {
                    int raw = await db.insertRow(TableNames.kpiPromotion, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
            case 'KPIPOSM':
              await db.deleteAll(TableNames.kpiPosm);
              try {
                List<PosmInfo> _lisPosm = (response.content as List)
                    .map((i) => PosmInfo.fromJson(i))
                    .toList();
                if (_lisPosm != null && _lisPosm.length > 0) {
                  modle.totalRawDownload = _lisPosm.length;
                  for (PosmInfo master in _lisPosm) {
                    int raw = await db.insertRow(TableNames.kpiPosm, master);
                    if (raw > 0) {
                      modle.totalRawInsert = modle.totalRawInsert + 1;
                      change(null, status: RxStatus.success());
                    }
                  }
                  if (modle.totalRawInsert == modle.totalRawDownload) {
                    modle.status = "Success";
                    change(null, status: RxStatus.success());
                  }
                }
              } catch (ex) {
                modle.status = "Error";
                response.statusCode = 500;
                response.content = modle.function + ": " + ex.toString();
                change(null, status: RxStatus.success());
              }
              break;
          }
        }
        if (response.statusCode != 200) {
          print('Lỗi' + response.statusCode.toString());
          alert(content: response.content.toString());
          isDownload = false;
          await hideProgess();
          return;
        }
      }
      isDownload = false;
      alert(content: 'Tải dữ liệu thành công !');
    } catch (ex) {
      isDownload = false;
    }
  }

  void init() {
    lstDownload = <DownloadModle>[].obs;
    lstDownload.add(new DownloadModle(
      id: 0,
      function: 'MASTERDATA',
      name: 'Master datas',
    ));
    lstDownload.add(new DownloadModle(
      id: 1,
      function: 'COINCOLLECT',
      name: 'Điểm tích lũy',
    ));
    lstDownload.add(new DownloadModle(
      id: 2,
      function: 'EVALUATEKPI',
      name: 'Kết quả đạt rớt 3 tháng gần nhất',
    ));
    lstDownload.add(new DownloadModle(
      id: 3,
      function: 'SUPPORT',
      name: 'Hỗ trợ online',
    ));
    lstDownload.add(new DownloadModle(
      function: 'DEVICE',
      name: 'Thông tin thiết bị',
    ));
    lstDownload.add(new DownloadModle(
      id: 4,
      function: 'KPIOSA',
      name: 'Báo cáo trưng bày',
    ));
    lstDownload.add(new DownloadModle(
      id: 5,
      function: 'KPISURVEY',
      name: 'Khảo sát',
    ));
    lstDownload.add(new DownloadModle(
      id: 6,
      function: 'KPISURVEYDETAIL',
      name: 'Danh ách câu hỏi khảo sát',
    ));
    lstDownload.add(new DownloadModle(
      id: 7,
      function: 'KPISURVEYANSWER',
      name: 'Danh ách câu trả lời khảo sát',
    ));
    lstDownload.add(new DownloadModle(
      id: 8,
      function: 'PRODUCTS',
      name: 'Sản phẩm',
    ));
    lstDownload.add(new DownloadModle(
      id: 9,
      function: 'KPIPOSM',
      name: 'Posm',
    ));
    lstDownload.add(new DownloadModle(
      id: 11,
      function: 'KPIPROMOTION',
      name: 'CTKM',
    ));
    lstDownload.add(new DownloadModle(
      id: 10,
      function: 'SHOPS',
      name: 'Danh sách cửa hàng',
    ));
    change(null, status: RxStatus.success());
  }
}
