import 'package:flutter/cupertino.dart';

class TabInfo {
  int id;
  String title;
  String icon;
  bool isSelected;
  Widget page;
  TabInfo({this.id, this.title, this.icon, this.isSelected, this.page,});
}
