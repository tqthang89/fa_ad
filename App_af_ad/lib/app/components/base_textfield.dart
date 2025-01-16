import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class BaseTextField extends StatefulWidget {
  final double height, radius, fontSize;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool isPassword;
  final TextAlign textAlign;
  final TextInputType textInputType;
  final String leftIcon, rightIcon, placeHolder;
  final Color borderColor, textColor, backgroundColor;
    final ValueChanged<String> onChanged;
    final bool enabled;
    final int maxLines;

  BaseTextField(
      {this.height = 45,
      this.radius = 0,
      this.focusNode,
      this.controller,
      this.isPassword = false,
      this.textAlign = TextAlign.left,
      this.textInputType,
      this.leftIcon,
      this.placeHolder = 'placeHolder...',
      this.fontSize = 15,
      this.rightIcon,
      this.borderColor,
      this.backgroundColor = Colors.white,
        this.maxLines = 1,
      this.textColor = AppStyle.text_base_Color, this.onChanged, this.enabled = true});
  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool obscureText = false;
  _BaseTextFieldState();
  Widget _getRightIcon() {
    if (widget.isPassword) {
      if (this.obscureText)
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          width: 25,
          height: 25,
          child: Image.asset(
            'assets/icons/ic_close_eye.png',
            fit: BoxFit.contain,
            color: AppStyle.primary,
          ),
        );
      else
        return Container(
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          width: 25,
          height: 25,
          child: Image.asset(
            'assets/icons/ic_eye.png',
            fit: BoxFit.contain,
            color: AppStyle.primary,
          ),
        );
    } else {
      this.setState(() {
        this.obscureText = false;
      });
      return (widget.rightIcon != null
          ? Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
              width: 25,
              height: 25,
              child: Image.asset(
                widget.rightIcon,
                fit: BoxFit.contain,
                color: AppStyle.barColor,
              ),
            )
          : SizedBox());
    }
  }

  @override
  void initState() {
    super.initState();
    this.obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor)
              : null,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        width: size.width,
        child: TextFormField(
          maxLines: widget.maxLines,
          enabled: widget.enabled ,
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: this.obscureText,
          style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
          textAlign: widget.textAlign,
          keyboardType: widget.textInputType,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    if (widget.isPassword) {
                      this.setState(() {
                        this.obscureText = !this.obscureText;
                      });
                    }
                  },
                  icon: _getRightIcon()),
              border: InputBorder.none,
              icon: widget.leftIcon != null
                  ? IconButton(
                      onPressed: () {
                        return;
                      },
                      icon: Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          widget.leftIcon,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  : SizedBox(),
              hintText: widget.placeHolder,
              //filled: true,
              hintStyle: TextStyle(
                color: widget.textColor,
                fontSize: widget.fontSize,
              )),
        ));
  }
}
