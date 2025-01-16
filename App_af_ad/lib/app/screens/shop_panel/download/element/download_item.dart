import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';
import 'package:syngentaaudit/app/screens/shop_panel/download/data/DownloadModle.dart';

// ignore: must_be_immutable
class DownloadItem extends StatelessWidget {
  Size size;
  DownloadModle modle;
  int index;
  DownloadItem({this.modle, this.size, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      width: size.width,
      child: Card(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      index.toString() + ". " + modle.name,
                      style: TextStyle(
                          color: AppStyle.primaryDart,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                          visible: modle.totalRawDownload != 0,
                          child:  Container(
                            width: 15,
                            height: 15,
                            child: Image.asset(
                              'assets/icons/ic_dot.png',
                              color: modle.getColorStatus(),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: new LinearPercentIndicator(
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 500,
                        percent: modle.getPercent(),
                        center: Text(modle.getPercentString()),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.greenAccent,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Text('Đã lưu ' +
                        modle.totalRawInsert.toString() +
                        '/' +
                        modle.totalRawDownload.toString()),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Text(
                  'Duration: ' + modle.getDuration().toString() + ' (s)',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
