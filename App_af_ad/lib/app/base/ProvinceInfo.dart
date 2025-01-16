class ProvinceInfo{
  String provinceName;
  int provinceId;

  ProvinceInfo({this.provinceName, this.provinceId});

  ProvinceInfo.fromJson(Map<String, dynamic> json) {
    provinceName = json['provinceName'];
    provinceId = json['provinceId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceName'] = this.provinceName;
    data['id'] = this.provinceId;
    return data;
  }
}