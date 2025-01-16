import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Color textColor;
  final VoidCallback leftClick;
  final VoidCallback rightClick;
  final IconData leftIcon;
  final Widget rightIcon;
  final Widget bottom;
  final Widget title;
  final bool rightIsNotify;
  final int notifyCount;
  final Widget flexibleSpace;
  final bool isShowBackGround;

  BaseAppBar(
      {Key key,
        this.leftClick,
        this.title,
        this.rightClick,
        this.height: 50,
        this.textColor: Colors.white,
        this.leftIcon,
        this.rightIcon,
        this.bottom,
        this.notifyCount = 0,
        this.rightIsNotify = false,
        this.flexibleSpace,
        this.isShowBackGround = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isShowBackGround ? Colors.transparent : null,
      bottom: bottom,
      centerTitle: true,
      title: title,
      actions: <Widget>[getRightIcon()],
      brightness: Brightness.dark,
      elevation: 50.0,
      leading: (leftIcon != null)
          ? IconButton(
        icon: Icon(leftIcon),
        color: Colors.white,
        onPressed: () {
          leftClick();
        },
      )
          : SizedBox(),
      flexibleSpace:
      flexibleSpace != null ? flexibleSpace : flexibleSpaceDefault(),
      automaticallyImplyLeading: true,
    );
  }

  Widget flexibleSpaceDefault() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppStyle.primary,
            AppStyle.primaryDart,
          ],
        ),
      ),
    );
  }

  Widget getRightIcon() {
    if (!this.rightIsNotify) {
      if (this.rightIcon != null) {
        return IconButton(
          icon: rightIcon,
          onPressed: () {
            rightClick();
          },
        );
      } else {
        return SizedBox();
      }
    } else {
      return InkWell(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              IconButton(
                icon: Image.asset(
                  "assets/icons/ic_notify.png",
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  rightClick();
                },
              ),
              Visibility(
                  visible: notifyCount > 0,
                  child: Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Text(
                            (this.notifyCount > 5)
                                ? "5+"
                                : this.notifyCount.toString(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            )),
                        radius: 10,
                      ),
                    ),
                  ))
            ],
          ),
        ),
        onTap: () {
          rightClick();
        },
      );
    }
  }

  @override
  Size get preferredSize => new Size.fromHeight(height);
}