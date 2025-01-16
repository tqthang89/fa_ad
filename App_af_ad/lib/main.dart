import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/controller_bindings.dart';
import 'app/routers/app_pages.dart';

Future<void> main() async {
  await GetStorage.init();
  
  runApp(
    GetMaterialApp(
      initialBinding: AllControllerBinding(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
