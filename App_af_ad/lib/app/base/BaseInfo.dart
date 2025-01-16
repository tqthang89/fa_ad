class BaseInfo {
  int rowId;

  BaseInfo({this.rowId});

  factory BaseInfo.fromJson(Map<String, dynamic> json) {
    return BaseInfo();
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    return map;
  }
}
