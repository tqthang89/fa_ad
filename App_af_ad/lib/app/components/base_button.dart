import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class BaseButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final double height;
  final double titleSize;
  final Color titleColor;
  final Color backgroud;

  const BaseButton(
      {Key key,
      this.onPressed,
      this.title = '',
      this.height = 40,
      this.titleSize = 15,
      this.titleColor = Colors.white,
      this.backgroud = AppStyle.primary})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Container(
      height: this.height,
      width: size.width,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            //side: BorderSide(color: Colors.red)
          )),
          backgroundColor: MaterialStateProperty.all(backgroud),
        ),
        onPressed: onPressed,
        child: Text(
          this.title,
          style: TextStyle(fontSize: this.titleSize, color: this.titleColor),
        ),
      ),
    );
  }
}
