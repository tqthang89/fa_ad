import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BaseGradientButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final String text;
  final Color textColor;
  final double fontSize;
  final double radius;

  const BaseGradientButton({
    Key key,
    @required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.onPressed,
    this.textColor = Colors.white,
    this.fontSize = 18,
    this.radius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          gradient: LinearGradient(
            colors: <Color>[const Color(0xFF0AC4F3),const Color(0xFF12B6F0),const Color(0xFF029CEC), const Color(0xFF008CD8)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
