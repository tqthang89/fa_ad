import 'package:syngentaaudit/app/base/BaseInfo.dart';

class PosmInfo extends BaseInfo {
  int shopId;
  int posmId;
  String posmName;
  String photo;
  int quantity;

  PosmInfo(
      {this.shopId, this.posmId, this.posmName, this.photo, this.quantity});

  PosmInfo.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    posmId = json['posmId'];
    posmName = json['posmName'];
    photo = json['photo'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['posmId'] = this.posmId;
    data['posmName'] = this.posmName;
    data['photo'] = this.photo;
    data['quantity'] = this.quantity;
    return data;
  }

  @override
  PosmInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    posmId = map['posmId'];
    posmName = map['posmName'];
    photo = map['photo'];
    quantity = map['quantity'];
    shopId = map['shopId'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "posmId": posmId,
        "posmName": posmName,
        "photo": photo,
        "quantity": quantity,
        "shopId": shopId,
      };
}
