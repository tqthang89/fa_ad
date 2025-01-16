import 'dart:io';

import 'package:syngentaaudit/app/core/Urls.dart';

import 'BaseInfo.dart';

class AudioInfo extends BaseInfo {
  int workId;
  int uploaded;
  String audioPath;
  String audioLocal;
  int playing;

  AudioInfo(
      {this.workId,
      this.uploaded,
      this.audioPath,
      this.audioLocal,
      this.playing = 0});

  AudioInfo.fromJson(Map<String, dynamic> json) {
    workId = json['workId'];
    uploaded = json['uploaded'];
    audioPath = json['audioPath'];
    audioLocal = json['audioLocal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['workId'] = this.workId;
    data['uploaded'] = this.uploaded;
    data['audioPath'] = this.audioPath;
    data['audioLocal'] = this.audioLocal;
    data['workId'] = this.workId;
    return data;
  }

  @override
  AudioInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    uploaded = map['uploaded'];
    audioPath = map['audioPath'];
    audioLocal = map['audioLocal'];
    workId = map['workId'];
    playing = 0;
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "uploaded": uploaded,
        "audioPath": audioPath,
        "audioLocal": audioLocal,
        "workId": workId,
      };

  String getUrl(int employeeId) {
    return Urls.ROOT + "Upload/Audios/" + getFileName(employeeId);
  }

  String getFileName(int employeeId) {
    File file = new File(audioLocal);
    String name = file.path.split("/").last;
    return employeeId.toString() + "_" + name;
  }
}
