import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class BaseViewPhotoDialog {
  static void show(String path, BuildContext context) {
    print("-------------------Show image--------------");
    print(path);
    Size size = MediaQuery.of(context).size;
    bool isUrl = Uri.parse(path).isAbsolute;

    print(isUrl);
    print(path);
    Get.defaultDialog(
        titleStyle: TextStyle(color: AppStyle.primaryDart),
        title: 'Hình ảnh',
        content: Container(
          width: size.width,
          height: size.height / 2,
          child: !isUrl
              ? (new File(path).existsSync())
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: PhotoView(
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        initialScale: PhotoViewComputedScale.covered * 1,
                        imageProvider: FileImage(new File(path)),
                      ))
                  : Center(
                      child: CircularProgressIndicator(),
                    )
              : PhotoView(
                  backgroundDecoration:
                      BoxDecoration(color: Colors.transparent),
                  initialScale: PhotoViewComputedScale.covered * 0.5,
                  imageProvider: NetworkImage(path, scale: 0.5)),
              //imageProvider: CachedNetworkImageProvider(path)),
        ),
        radius: 10.0);
  }
}
