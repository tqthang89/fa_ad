import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syngentaaudit/app/base/CoinCollectInfo.dart';
import 'package:syngentaaudit/app/base/EvaluateResultInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/models/CollectQuaterCoinModel.dart';
import 'package:syngentaaudit/app/screens/shop/shop_controller.dart';

class ShopReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopReportState();
  }
}

class ShopReportState extends State<ShopReport> {
  ShopInfo shop;
  ShopController controller;
  RxList<EvaluateResultInfo> lstEvaluateResultInfo = <EvaluateResultInfo>[].obs;
  RxList<CollectQuaterCoinModel> lstCoinCollectInfo =
      <CollectQuaterCoinModel>[].obs;
  Rx<int> totalCoin = 0.obs;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      shop = Get.arguments[0];
      controller = Get.find();
      lstEvaluateResultInfo.value =
          await AuditContext.getEvaluateResult(shop.shopId);
      List<CoinCollectInfo> data =
          await AuditContext.getCoinCollect(shop.shopId);
      if (data != null && data.length > 0) {
        for (CoinCollectInfo collectInfo in data) {
          totalCoin.value = totalCoin.value + collectInfo.coins;
          if (lstCoinCollectInfo.length > 0) {
            List<CollectQuaterCoinModel> lstModel =
                new List.empty(growable: true);
            for (CollectQuaterCoinModel model in lstCoinCollectInfo) {
              if (model.quaterGroup == collectInfo.quarter) {
                lstModel.add(model);
              }
            }
            if (lstModel.length == 0) {
              CollectQuaterCoinModel model = new CollectQuaterCoinModel();
              model.quaterGroup = collectInfo.quarter;
              model.totalCoin = 0;
              model.data = new List.empty(growable: true);
              lstCoinCollectInfo.add(model);
            }
          } else {
            CollectQuaterCoinModel model = new CollectQuaterCoinModel();
            model.quaterGroup = collectInfo.quarter;
            model.totalCoin = 0;
            model.data = new List.empty(growable: true);
            lstCoinCollectInfo.add(model);
          }
        }
        if (lstCoinCollectInfo.length > 0) {
          for (CollectQuaterCoinModel model in lstCoinCollectInfo) {
            for (CoinCollectInfo coin in data) {
              if (model.quaterGroup == coin.quarter) {
                model.totalCoin = model.totalCoin + coin.coins;
                model.data.add(coin);
              }
            }
          }
        }
      }
    } catch (ex) {
      controller.alert(content: ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Color(0xFFE9E9E9),
                style: BorderStyle.solid,
                width: 1.0,
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    'Kết quả chấm 3 tháng gần nhất',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 0, 5),
                  alignment: Alignment.center,
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Text(
                        'NGÀY CHẤM',
                        style: TextStyle(color: AppStyle.text_base_Color),
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        'GÓI T/BÀY',
                        style: TextStyle(color: AppStyle.text_base_Color),
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        'KẾT QUẢ',
                        style: TextStyle(color: AppStyle.text_base_Color),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  ),
                ),
                Obx(() => ListView.builder(
                      shrinkWrap: true,
                      itemCount: lstEvaluateResultInfo.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xFFE9E9E9),
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Text(
                                lstEvaluateResultInfo[index].evaluateDate,
                                style:
                                    TextStyle(color: AppStyle.text_base_Color),
                                textAlign: TextAlign.center,
                              )),
                              Expanded(
                                  child: Text(
                                lstEvaluateResultInfo[index].kpiFormatName,
                                style: TextStyle(
                                    color: lstEvaluateResultInfo[index]
                                        .getColorKPIName(),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: lstEvaluateResultInfo[index]
                                      .getColorBackgroudResultName(),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Visibility(
                                      visible: lstEvaluateResultInfo[index]
                                              .resultStatus ==
                                          1,
                                      child: Image.asset(
                                        'assets/icons/ic_vector.png',
                                        width: 15,
                                        height: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      lstEvaluateResultInfo[index].resultName,
                                      style: TextStyle(
                                          color: lstEvaluateResultInfo[index]
                                              .getColorResultName()),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFE9E9E9),
                style: BorderStyle.solid,
                width: 1.0,
              ),
            ),
            height: 180,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 15),
                  alignment: Alignment.center,
                  width: size.width,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    'Điểm tích lũy (' + totalCoin.toString() + ')',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Obx(() => Scrollbar(
                        isAlwaysShown: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: lstCoinCollectInfo.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                      width: size.width,
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              child: VerticalDivider(
                                                color: AppStyle.primary,
                                                thickness: 5,
                                              ),
                                            ),
                                            Text(
                                              'Quý ' +
                                                  lstCoinCollectInfo[index]
                                                      .quaterGroup
                                                      .toString() +
                                                  ": " +
                                                  lstCoinCollectInfo[index]
                                                      .totalCoin
                                                      .toString() +
                                                  " điểm",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Container(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: lstCoinCollectInfo[index]
                                            .data
                                            .length,
                                        itemBuilder: (context, position) {
                                          return Container(
                                            margin: EdgeInsets.fromLTRB(
                                                15, 5, 0, 0),
                                            child: Text(
                                              lstCoinCollectInfo[index]
                                                      .data[position]
                                                      .month +
                                                  ":  " +
                                                  lstCoinCollectInfo[index]
                                                      .data[position]
                                                      .coins
                                                      .toString() +
                                                  " điểm",
                                              style: TextStyle(
                                                  color:
                                                      AppStyle.text_base_Color),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                          },
                        )))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
