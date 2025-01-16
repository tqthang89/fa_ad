import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syngentaaudit/app/base/LoginInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/screens/shop/shop_controller.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShopDetailState();
  }
}

class ShopDetailState extends State<ShopDetail> {
  ShopInfo shop;
  ShopController controller;

  ImagePicker picker = ImagePicker();
  LoginInfo loginInfo;

  @override
  void initState() {
    controller = Get.find();
    shop = Get.arguments[0];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getShopOVVPath(shop);
    });
    super.initState();
  }

  Future<void> callWitiPhoneNumner(String phone) async {
    try {
      if (!phone.isNullOrWhiteSpace()) {
        await launch("tel://" + phone);
      }
    } catch (ex) {
      controller.alert(content: ex.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width,
      width: size.height,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_full_selection.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Tên CH',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 200,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                shop != null &&
                                        shop.shopName.isNullOrWhiteSpace()
                                    ? ''
                                    : shop.shopName,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: DottedBorder(
                //     color: AppStyle.primary,
                //     radius: Radius.circular(20),
                //     child: Container(
                //       padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                //       color: const Color(0xFFF6FFED),
                //       child:
                //         // Text(
                //       //   shop != null && shop.shopName.isNullOrWhiteSpace()
                //       //       ? ''
                //       //       : shop.shopName,
                //       //   style: TextStyle(
                //       //       fontSize: 15, fontWeight: FontWeight.bold),
                //       // ),
                //         Expanded(
                //             child: Text(
                //               shop != null && shop.shopName.isNullOrWhiteSpace()
                //                   ? ''
                //                   : shop.shopName,
                //               textAlign: TextAlign.left,
                //             ))
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Tên chủ CH',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Row(
                      children: [
                        Text(shop != null &&
                                shop.contactName.isNullOrWhiteSpace()
                            ? ''
                            : shop.contactName),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Số điện thoại',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Row(
                      children: [
                        Text(shop != null && shop.phone.isNullOrWhiteSpace()
                            ? ''
                            : shop.phone),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/icons/ic_phone.png',
                            width: 35,
                            height: 35,
                          ),
                          onTap: () {
                            callWitiPhoneNumner(shop.phone);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Địa chỉ',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 200,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          shop != null && shop.address.isNullOrWhiteSpace()
                              ? ''
                              : shop.address,
                          textAlign: TextAlign.right,
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('SĐT Sales',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                            shop != null && shop.salesPhone.isNullOrWhiteSpace()
                                ? ''
                                : shop.salesPhone),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          child: Image.asset(
                            'assets/icons/ic_phone.png',
                            width: 35,
                            height: 35,
                          ),
                          onTap: () {
                            callWitiPhoneNumner(shop.salesPhone);
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Gói đăng ký',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    shop != null && shop.formatName.isNullOrWhiteSpace()
                        ? ''
                        : shop.formatName,
                    style: TextStyle(
                        color: AppStyle.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Loại hình CH',
                      style: TextStyle(
                          fontSize: 15, color: AppStyle.text_base_Color)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    shop != null && shop.shopType.isNullOrWhiteSpace()
                        ? ''
                        : shop.shopType,
                    style: TextStyle(
                        color: AppStyle.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Divider(color: Colors.grey),
          Container(
            padding: EdgeInsets.all(10),
            width: size.width,
            height: 200,
            child: Obx(() => shop != null ? photoView() : Center()),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              width: size.width,
              height: 200,
              child: DottedBorder(
                color: AppStyle.primary,
                radius: Radius.circular(20),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xFFF6FFED),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/icons/ic_camera.png',
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Chụp hình overview',
                        style: TextStyle(color: AppStyle.primary, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            onTap: () => !controller.work.value.locked ? startCamera() : null,
          )
        ],
      )),
    );
  }

  Future<void> startCamera() async {
    controller.isEnableGPS();
    await controller.setPosition();
    // Position gps = await GeolocatorPlatform.instance.getCurrentPosition();
    // if (gps.isMocked) {
    //   controller.alert(
    //       content:
    //           'Bạn đang sử dụng giả lập GPS. Vui lòng tắt ứng dụng giả lập !');
    //   return;
    // }
    try {
      // ignore: deprecated_member_use
      PickedFile pickedFile = await picker.getImage(
          source: ImageSource.camera, maxWidth: 960, imageQuality: 90);
      if (pickedFile != null && !pickedFile.path.isNullOrWhiteSpace()) {
        await controller.showProgess();
        // ignore: unused_local_variable
        File file = await FileUtils.createImage();
        await FileUtils.createImage()
            .then((file) => controller.saveOVV(file, shop, pickedFile));
      } else {
        await controller.hideProgess();
        controller.alert(
            content: "Lưu ảnh không thành công vui lòng thử lại !");
        return;
      }
    } catch (ex) {
      controller.alert(content: ex.toString());
      await controller.hideProgess();
    }
  }

  Widget photoView() {
    if (controller.overview.value == null) {
      if (!shop.photo.isNullOrWhiteSpace()) {
        return CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: shop.photo,
          placeholder: (context, url) => Container(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      } else {
        return SizedBox();
      }
    } else {
      if (!ExString(controller.overview.value.attendantPhoto)
          .isNullOrWhiteSpace()) {
        File file = new File(FileUtils.GetFilePath(
            controller.DirectoryPath,
            controller.overview.value.attendantPhoto,
            controller.work.value.workDate.toString()));
        //File file = new File(controller.overview.value.attendantPhoto);
        if (file != null && file.existsSync() && file.lengthSync() > 0) {
          return Image.file(
            file,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
          );
        } else {
          return Center(
              child: Text(
            'Ảnh không tồn tại hoặc bị xóa !',
            style: TextStyle(color: AppStyle.text_base_Color),
          ));
        }
      } else {
        if (!shop.photo.isNullOrWhiteSpace()) {
          return CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: shop.photo,
            placeholder: (context, url) => Container(
              padding: EdgeInsets.all(10),
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        } else {
          return SizedBox();
        }
      }
    }
  }
}
