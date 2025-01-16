import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';

class DownloadModle extends BaseInfo {
  int id;
  String function;
  String name;
  int totalRawDownload;
  int totalRawInsert;
  int percent;
  String status;
  DateTime startTime;
  DateTime endTime;
  DownloadModle(
      {this.id,
      this.function,
      this.name,
      this.totalRawDownload = 0,
      this.totalRawInsert = 0,
      this.status = "Created"});

  double getDuration() {
    int duration = 0;
    if (startTime != null && endTime != null) {
      duration = endTime.difference(startTime).inMilliseconds;
    }
    return duration.toDouble()/1000;
  }

  getColorStatus() {
    if (status == "Download") {
      return Colors.orange;
    }
    if (status == "Success") {
      return Colors.green;
    }
    if (status == "Error") {
      return Colors.red;
    }
  }

  getPercent() {
    if (totalRawInsert == totalRawDownload && totalRawInsert != 0) {
      return 1.toDouble();
    } else if (totalRawInsert == totalRawDownload && totalRawDownload == 0) {
      return 0.toDouble();
    } else {
      return (totalRawInsert / totalRawDownload).toDouble();
    }
  }

  getPercentString() {
    if (totalRawInsert == totalRawDownload && totalRawInsert != 0) {
      return (1 * 100).toInt().toString() + "%";
    } else if (totalRawInsert == totalRawDownload && totalRawDownload == 0) {
      return "";
    } else {
      return ((totalRawInsert / totalRawDownload) * 100).toInt().toString() +
          "%";
    }
  }
}
