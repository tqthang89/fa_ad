import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';
import 'package:syngentaaudit/app/screens/record/record_controller.dart';

class Record extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecordState();
  }
}

class RecordState extends State<Record> {
  ShopInfo shop;
  RecordController controller;
  WorkResultInfo work;
  List<AudioInfo> listAudio = new List.empty(growable: true);

  @override
  void initState() {
    controller = Get.find();
    shop = Get.arguments[0];
    work = Get.arguments[1];
    controller.work = work.obs;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller
          .initRecord(shop)
          .then((value) => controller.getListAudio(controller.work.value));
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.closeAudio();
    super.dispose();
  }

  @override
  void deactivate() {
    controller.recorder.stopRecorder();
    controller.player.stop();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return WillPopScope(
      child: Scaffold(
        appBar: BaseAppBar(
          title: Text('Ghi âm cửa hàng'),
          rightIsNotify: false,
          isShowBackGround: false,
          flexibleSpace: Container(
            height: size.height / 5 + 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    AppStyle.primary,
                    AppStyle.primaryDart
                  ],
                ),
              ),
            ),
          ),
          height: 50,
          leftIcon: Icons.arrow_back_ios_new,
          leftClick: controller.backPressed,
        ),
        body: recordControlLayout(context),
      ),
      onWillPop: controller.backPressed,
    );
  }

  Widget recordControlLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFB7EB8F)),
                borderRadius: BorderRadius.circular(10)),
            child: Obx(() => ListView.builder(
                itemCount: controller.lstAudio.length,
                itemBuilder: (BuildContext context, int index) =>
                    itemAudio(controller.lstAudio[index]))),
          ),
        ),
        LimitedBox(
            maxHeight: 200,
            maxWidth: Utility.getWidthScreen(context),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(() => Text(
                          controller.timeText.value != null &&
                                  !ExString(controller.timeText.value)
                                      .isNullOrWhiteSpace()
                              ? '${controller.timeText.value}'
                              : "00:00",
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    child: IconButton(
                        icon: Icon(
                          Icons.play_arrow_sharp,
                          color: Colors.blue,
                        ),
                        onPressed: () => !controller.work.value.locked
                            ? {
                                if (!controller.recorder.isRecording)
                                  {
                                    controller.startRecording(),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Bắt đầu ghi âm."))),
                                  }
                                else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Đang quá trình ghi âm."))),
                                  }
                              }
                            : null),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    child: IconButton(
                        icon: Icon(
                          Icons.stop_circle_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () => !controller.work.value.locked
                            ? {
                                controller.stopRecording(),
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Ngưng ghi âm."),
                                )),
                              }
                            : null),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                  ),
                ],
              ),
            ])),
      ]),
    );
  }

  Widget itemAudio(AudioInfo audio) {
    return Card(
      elevation: 5,
      color: Colors.grey.shade50,
      child: Container(
        height: 50,
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          children: [
            LimitedBox(
                maxWidth: 50,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(5)),
                    width: 50,
                    child: audio.playing == 0
                        ? Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.stop,
                            color: Colors.red,
                          ),
                  ),
                  onTap: () => controller.play(audio),
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Text(audio.audioPath),
            )
          ],
        ),
      ),
    );
  }
}
