import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/MobileSupportInfo.dart';
import 'package:syngentaaudit/app/core/HttpResponseMessage.dart';
import 'package:syngentaaudit/app/core/HttpUtils.dart';
import 'package:syngentaaudit/app/core/Urls.dart';
import 'package:syngentaaudit/app/core/Utility.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'dart:io' as Io;
import '../../base_controller.dart';

class ToolController extends BaseController {
  DatabaseHelper db = new DatabaseHelper();
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  Future<void> supportOnline() async {
    if (await Utility.isInternetConnected()) {
      await showProgess();
      try {
        Map<String, String> params = new Map();
        params["FUNCTION"] = "SUPPORT";
        HttpResponseMessage response =
            await HttpUtils.post(url: Urls.DOWNLOAD, body: params);
        List<MobileSupportInfo> _listsupport = (response.content as List)
            .map((i) => MobileSupportInfo.fromJson(i))
            .toList();
        if (_listsupport != null && _listsupport.length > 0) {
          _listsupport.forEach((element) async {
            await db.execute(element.queryString);
          });
        }
        await hideProgess();
      } catch (ex) {
        await hideProgess();
        alert(content: ex.toString());
        return;
      }
    } else {
      alert(content: "Vui lòng kiểm tra lại kết nối Internet !");
      return;
    }
  }

  Future<void> uploadDB() async {
    if (await Utility.isInternetConnected()) {
      await showProgess();
      try {
        File file = new File(await DatabaseHelper.getPath());
        if (file != null && file.existsSync() && file.lengthSync() > 0) {
          Map<String, String> params = new Map();
          params["FUNCTION"] = "EXPORTDB";
          HttpResponseMessage response = await HttpUtils.uploadFile(
              url: Urls.DOWNLOAD, body: params, file: file);
          await progess.hide();
          alert(content: response.content.toString());
        }
      } catch (ex) {
        await progess.hide();
        alert(content: ex.toString());
      }
    } else {
      alert(content: "Vui lòng kiểm tra lại kết nối Internet !");
      return;
    }
  }

  Future<void> downloadDB() async {
    if (await Utility.isInternetConnected()) {
      try {
        await showProgess();
        Map<String, String> body = new Map();
        body["FUNCTION"] = "IMPORTDB";
        var response = await HttpUtils.download(url: Urls.DOWNLOAD, body: body);
        await progess.hide();
        HttpResponseMessage model = new HttpResponseMessage();
        var jsonData = json.decode(response.body);
        try {
          model = HttpResponseMessage.fromJson(jsonData);
        } catch (ex) {
          alert(content: jsonData["Content"].toString());
          return;
        }
        if (model.statusCode == 200) {
          File file = new File(await DatabaseHelper.getPath());
          if (file.existsSync()) {
            file.deleteSync();
          }
          file = new File(await DatabaseHelper.getPath());
          await Io.File(file.path).writeAsBytes(response.bodyBytes);
          await progess.hide();
          alert(
              content:
                  "Đồng bộ dữ liệu thành công vui lòng tắt app rồi mở lại !");
          return;
        } else {
          await progess.hide();
          alert(content: model.content.toString());
          return;
        }
      } catch (ex) {
        await progess.hide();
        alert(content: ex.toString());
        return;
      }
    } else {
      alert(content: "Vui lòng kiểm tra lại kết nối Internet");
      return;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
