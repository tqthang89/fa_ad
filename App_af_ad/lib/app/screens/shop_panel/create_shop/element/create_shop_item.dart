import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/AreaInfo.dart';
import 'package:syngentaaudit/app/base/DistrictInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/ProvinceInfo.dart';
import 'package:syngentaaudit/app/base/TownInfo.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/base/CreateShopInfo.dart';
import 'package:syngentaaudit/app/screens/kpis/surveyComponents/albumImages.dart';
import 'package:syngentaaudit/app/screens/shop_panel/create_shop/create_shop_controller.dart';

class CreateShopItem extends StatelessWidget {
  final CreateShopController controller;
  final CreateShopInfo item;
  final int index;
  final BuildContext context;

  CreateShopItem({this.context, this.controller, this.item, this.index});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40),
      child: Column(
        children: [
          Visibility(
            visible: !ExString(item.group).isNullOrWhiteSpace() ? true : false,
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
              ),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VerticalDivider(
                    width: 15,
                    color: const Color(0xFF15D48A),
                    thickness: 4,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(item.group),
                    ),
                  )
                ],
              ),
            ),
          ),
          ConstrainedBox(
              constraints: BoxConstraints(minHeight: 60),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(item.title),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: widgetType(item, index),
                          )),
                    ],
                  ),
                  Visibility(
                    visible: index == 3 ? true : false,
                    child: Container(
                      height: 140,
                      padding: EdgeInsets.all(5),
                      child:
                          Column(
      children: [Text("Chụp 2 tấm hình ("+ controller.CountImage.value.toString() +" hình ) ",style: TextStyle(color: Colors.red),),
        Visibility(
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
                        onPressed: () {
                          controller.startCamera();
                        },
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            padding: EdgeInsets.all(20),
                            backgroundColor:
                            const Color(0xFFF6FFED)),
                        icon: Icon(Icons.camera_alt_rounded,
                            color: const Color(0xFF32B768),
                            size: 30),
                        label: Text("")),
                  )
              ),

              SizedBox(
                width: 20,
              ),
              LimitedBox(
                maxHeight: 100,
                maxWidth: 140,
                child: DottedBorder(
                    child: !ExString(controller.result.photo).isNullOrWhiteSpace()
                        ? CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: controller.result.photo,
                      placeholder: (context, url) => Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 60,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ):
                    Padding(padding: EdgeInsets.all(25),  child: Icon(Icons.photo,color: Colors.grey,))
                ),
              )
            ],
          ),
        ),

    ],
    )
                      
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget widgetType(CreateShopInfo item, int index) {
    if (item.type == "T") {
      if(index != 3) {
        return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 40),
            child: TextFormField(
              controller: index == 0
                  ? controller.result.merchantNameController
                  : index == 1
                  ? controller.result.phoneController
                  : index == 2 //: index == 5
                  ? controller.result.addresslineController
                  : index == 7
                  ? controller.result.itemDisplayController
                  : index == 8
                  ? controller.result.typeDisplayController
                  : controller.result.revenueController,
              onChanged: (value) async {
                await new Future.delayed(new Duration(milliseconds: 50),
                        () async {
                      try {
                        controller
                            .insertData(
                            index: index, type: item.type, value: value)
                            .then((value) {
                          //FocusScope.of(context).requestFocus(new FocusNode());
                        });
                      } catch (ex) {
                        controller.alert(content: ex.toString());
                        FocusScope.of(context).requestFocus(new FocusNode());
                      }
                    });
              },
              decoration: new InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  contentPadding: EdgeInsets.all(5),
                  hintText: ""),
            ));
      }
    } else if (item.type == "N") {
      return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 40),
          child: TextFormField(
            controller: controller.result.phoneController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: false),
            onChanged: (value) async {
              await new Future.delayed(new Duration(milliseconds: 50),
                  () async {
                try {
                  int nvalue = int.tryParse(value);
                  controller
                      .insertData(index: index, type: item.type, nvalue: nvalue)
                      .then((value) {
                    //FocusScope.of(context).requestFocus(new FocusNode());
                  });
                } catch (ex) {
                  controller.alert(content: ex.toString());
                  FocusScope.of(context).requestFocus(new FocusNode());
                }
              });
            },
            decoration: new InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                contentPadding: EdgeInsets.all(5),
                hintText: ""),
          ));
    } else if (item.type == 'SP') {
      return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xFFD9D9D9))),
          child: DropdownButton<ProvinceInfo>(
            value: controller.selectProvince.value,
            items: controller.lstProvince.map((ProvinceInfo value) {
              return DropdownMenuItem<ProvinceInfo>(
                value: value,
                child: Text(value.provinceName),
              );
            }).toList(),
            isDense: true,
            isExpanded: true,
            underline: SizedBox(),
            hint: Text(""),
            onChanged: (ProvinceInfo select) async {
              controller.loadDistrict(select).then((value) {
                controller.insertData(
                    index: index, type: item.type, svalue: select.provinceId);
              });
            },
          ));
    }
    else if (item.type == 'SD') {
      return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xFFD9D9D9))),
          child: DropdownButton<DistrictInfo>(
            value: controller.selectDistrict.value,
            items: controller.lstDistrictByProvince.map((DistrictInfo value) {
              return DropdownMenuItem<DistrictInfo>(
                value: value,
                child: Text(value.districtName),
              );
            }).toList(),
            isDense: true,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (DistrictInfo select) async {
              controller.loadTown(select).then((value) {
                controller.insertDistrict(select).then((value) {
                  controller.insertData(
                      index: index, type: item.type, svalue: select.districtId);
                });
              });
            },
          ));
    }
    else if (item.type == 'ST') {
      return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xFFD9D9D9))),
          child: DropdownButton<TownInfo>(
            value: controller.selectTown.value,
            items: controller.lstTown.map((TownInfo value) {
              return DropdownMenuItem<TownInfo>(
                value: value,
                child: Text(value.townName),
              );
            }).toList(),
            isDense: true,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (TownInfo select) async {
              controller.insertTown(select).then((value) {
                controller.insertData(
                    index: index, type: item.type, svalue: select.townId);
              });

            },
          ));
    }
    else {
      return Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: const Color(0xFFD9D9D9))),
          child: DropdownButton<AreaInfo>(
            value: controller.selectArea.value,
            items: controller.lstArea.map((AreaInfo value) {
              return DropdownMenuItem<AreaInfo>(
                value: value,
                child: Text(value.areaName),
              );
            }).toList(),
            isDense: true,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (AreaInfo select) async {
              controller.insertAreaDisplay(select).then((value) {
                controller.insertData(
                    index: index, type: item.type, svalue: select.areaId);
              });
            },
          ));
    }
  }
}
