class AreaInfo{
  String areaName;
  int areaId;

  AreaInfo({this.areaName, this.areaId});

  AreaInfo.fromJson(Map<String, dynamic> json) {
    areaName = json['areaName'];
    areaId = json['areaId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['areaName'] = this.areaName;
    data['areaId'] = this.areaId;
    return data;
  }
}