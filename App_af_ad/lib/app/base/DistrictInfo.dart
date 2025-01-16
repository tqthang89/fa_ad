class DistrictInfo{
  String districtName;
  int provinceId;
  int districtId;

  DistrictInfo({this.districtName, this.districtId,this.provinceId});

  DistrictInfo.fromJson(Map<String, dynamic> json) {
    districtName = json['districtName'];
    districtId = json['districtId'];
    provinceId = json['provinceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtName'] = this.districtName;
    data['districtId'] = this.districtId;
    data['provinceId'] = this.provinceId;
    return data;
  }
}