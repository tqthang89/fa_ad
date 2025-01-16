class TownInfo{
  String townName;
  int townId;
  int districtId;

  TownInfo({this.townName, this.districtId,this.townId});

  TownInfo.fromJson(Map<String, dynamic> json) {
    townName = json['townName'];
    districtId = json['districtId'];
    townId = json['townId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['townName'] = this.townName;
    data['districtId'] = this.districtId;
    data['townId'] = this.townId;
    return data;
  }
}