import 'package:syngentaaudit/app/base/BaseInfo.dart';

class OsaInfo extends BaseInfo {
  int productId;
  int shopFormatId;
  int checkPrice;
  int targetOSA;

  OsaInfo({this.productId, this.shopFormatId, this.checkPrice, this.targetOSA});

  OsaInfo.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    shopFormatId = json['shopFormatId'];
    checkPrice = json['checkPrice'];
    targetOSA = json['targetOSA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['shopFormatId'] = this.shopFormatId;
    data['checkPrice'] = this.checkPrice;
    data['targetOSA'] = this.targetOSA;
    return data;
  }

  @override
  OsaInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    productId = map['productId'];
    shopFormatId = map['shopFormatId'];
    checkPrice = map['checkPrice'];
    targetOSA = map['targetOSA'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "productId": productId,
        "shopFormatId": shopFormatId,
        "checkPrice": checkPrice,
        "targetOSA": targetOSA,
      };
}
