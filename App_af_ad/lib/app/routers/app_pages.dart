import 'package:get/get.dart';
import 'package:syngentaaudit/app/apple/shop/ShopAuditApple.dart';
import 'package:syngentaaudit/app/apple/shoplist/ShopListAppleView.dart';
import 'package:syngentaaudit/app/screens/kpis/kpi_binding.dart';
import 'package:syngentaaudit/app/screens/kpis/osa.dart';
import 'package:syngentaaudit/app/screens/kpis/osa_mt.dart';
import 'package:syngentaaudit/app/screens/kpis/posm.dart';
import 'package:syngentaaudit/app/screens/kpis/promotion.dart';
import 'package:syngentaaudit/app/screens/kpis/survey.dart';
import 'package:syngentaaudit/app/screens/login/login.dart';
import 'package:syngentaaudit/app/screens/panel/panel.dart';
import 'package:syngentaaudit/app/screens/record/record.dart';
import 'package:syngentaaudit/app/screens/record/record_binding.dart';
import 'package:syngentaaudit/app/screens/shop/shop.dart';
import 'package:syngentaaudit/app/screens/shop/shop_binding.dart';
import 'package:syngentaaudit/app/screens/shop_panel/create_shop/create_shop.dart';
import 'package:syngentaaudit/app/screens/shop_panel/map/map.dart';
import 'package:syngentaaudit/app/screens/shop_panel/shop_panel.dart';
import 'package:syngentaaudit/app/screens/tools/tool.dart';
import 'package:syngentaaudit/app/screens/welcome/welcome.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.WELCOME;
  static const DEFAULT_TRANSITION = Transition.rightToLeft;

  static final routes = [
    GetPage(
      name: Paths.WELCOME,
      page: () => WelcomeView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.PANEL,
      page: () => PanelView(),
    ),
    GetPage(
        transition: DEFAULT_TRANSITION,
        name: Paths.SHOP,
        page: () => Shop(),
        binding: ShopBinding()),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOP_PANEL,
      page: () => ShopPanelView(),
    ),
    GetPage(
        transition: DEFAULT_TRANSITION,
        name: Paths.SURVEY,
        page: () => Survey(),
        binding: KPIBinding()),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.MAP,
      page: () => MapView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.POSM,
      page: () => Posm(),
      binding: KPIBinding(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.PROMOTION,
      page: () => Promotion(),
      binding: KPIBinding(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.OSA,
      page: () => Osa(),
      binding: KPIBinding(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.OSAMT,
      page: () => OsaMT(),
      binding: KPIBinding(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.TOOL,
      page: () => ToolView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.RECORD,
      page: () => Record(),
      binding: RecordBinding(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.CREATE,
      page: () => CreateShop(),
    ),

    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOPLISTAPPLE,
      page: () => ShopListAppleView(),
    ),
    GetPage(
      transition: DEFAULT_TRANSITION,
      name: Paths.SHOPAPPLE,
      page: () => ShopAuditApple(),
    ),
  ];
}
