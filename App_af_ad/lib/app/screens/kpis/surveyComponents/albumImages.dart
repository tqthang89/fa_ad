import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/core/Utility.dart';

class AlbumImages extends StatefulWidget {
  final List<PhotoInfo> photos;

  AlbumImages({@required this.photos});

  @override
  State<StatefulWidget> createState() {
    return AlbumImagesState(this.photos);
  }
}

class AlbumImagesState extends State<AlbumImages> {
  List<PhotoInfo> photos;
  int index = 0;

  AlbumImagesState(this.photos);

  ScrollController _scrollController;
  String DirectoryPath = "";
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        print("offset = ${_scrollController.position}");
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      DirectoryPath = directory.path;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: BaseAppBar(
        title: Text("Hình ảnh"),
        rightIsNotify: false,
        isShowBackGround: false,
        flexibleSpace: Container(
          height: size.height / 5 + 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  const Color(0xFF15D48A),
                  const Color(0xFF0A7D60)
                ],
              ),
            ),
          ),
        ),
        height: 50,
        leftIcon: Icons.arrow_back_ios_new,
        leftClick: onBackPress,
        rightIcon: null,
      ),
      body: Container(
        width: Utility.getWidthScreen(context),
        height: Utility.getHeightScreen(context),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
                width: Utility.getWidthScreen(context),
                height: Utility.getHeightScreen(context),
                child: Stack(
                  children: [
                    (photos != null &&
                            photos.length > 0 &&
                            photos[index] != null &&
                            new File(FileUtils.GetFilePath(
                                    DirectoryPath,
                                    photos[index].photoPath,
                                    photos[index].workDate.toString()))
                                .existsSync())
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PhotoView(
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.transparent),
                              initialScale: PhotoViewComputedScale.covered * 1,
                              imageProvider: FileImage(new File(
                                  FileUtils.GetFilePath(
                                      DirectoryPath,
                                      photos[index].photoPath,
                                      photos[index].workDate.toString()))),
                            ))
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ],
                ),
              ),
              flex: 8,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: Utility.getWidthScreen(context),
                height: Utility.getWidthScreen(context) / 4,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: (photos != null) ? photos.length : 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          width: 70,
                          height: 70,
                          child: Card(
                              elevation: 2,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.0),
                                  child: Image.file(
                                    new File(FileUtils.GetFilePath(
                                        DirectoryPath,
                                        photos[index].photoPath,
                                        photos[index].workDate.toString())),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    height: double.infinity,
                                    width: double.infinity,
                                  ))),
                        ),
                        onTap: () {
                          setState(() {
                            this.index = index;
                          });
                        },
                      );
                    }),
              ),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }

  onBackPress() {
    Get.back();
  }
}
