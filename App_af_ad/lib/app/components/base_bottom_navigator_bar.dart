import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/TabInfo.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class BaseBottomNavigationBar extends StatefulWidget {
  final List<TabInfo> bars;
  final Function(int) onTap;
  final int currentIndex;
  BaseBottomNavigationBar({this.bars, this.onTap, this.currentIndex});
  @override
  State<StatefulWidget> createState() {
    return _BaseBottomNavigationBarState();
  }
}

class _BaseBottomNavigationBarState extends State<BaseBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white, // default background
          splashColor: Colors.white, // background when click
          unselectedWidgetColor: Colors.grey,
          primaryColor: AppStyle.primary,
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: new TextStyle(
                  color: Colors
                      .grey))), // sets the inactive color of the `BottomNavigationBar`
      child: new BottomNavigationBar(
        selectedItemColor: AppStyle.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          widget.onTap(index);
        },
        items: barsList(),
      ),
    );
  }

  List<BottomNavigationBarItem> barsList() {
    List<BottomNavigationBarItem> _list = new List.empty(growable: true);
    if (widget.bars != null && widget.bars.length > 0) {
      widget.bars.forEach((element) {
        _list.add(BottomNavigationBarItem(
          label: element.title,
          icon: Image.asset(
            element.icon,
            width: 30.0,
            height: 30.0,
            color: element.isSelected ? AppStyle.primary : Colors.grey,
          ),
        ));
      });
    } else {
      return null;
    }
    return _list;
  }
}
