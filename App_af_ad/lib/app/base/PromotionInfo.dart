import 'package:syngentaaudit/app/base/BaseInfo.dart';

class PromotionInfo extends BaseInfo {
  int shopId;
  int promotionId;
  String scheme;
  int fromdate;
  int todate;
  int productid;
  String productdescription;

  PromotionInfo(
      {this.shopId, this.promotionId, this.scheme, this.fromdate, this.todate,this.productid,this.productdescription});

  PromotionInfo.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    promotionId = json['promotionId'];
    scheme = json['scheme'];
    fromdate = json['fromdate'];
    todate = json['todate'];
    productid = json['productid'];
    productdescription = json['productdescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['promotionId'] = this.promotionId;
    data['scheme'] = this.scheme;
    data['fromdate'] = this.fromdate;
    data['todate'] = this.todate;
    data['productid'] = this.productid;
    data['productdescription'] = this.productdescription;
    return data;
  }

  @override
  PromotionInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    shopId = map['shopId'];
    promotionId = map['promotionId'];
    scheme = map['scheme'];
    fromdate = map['fromdate'];
    todate = map['todate'];
    productid = map['productid'];
    productdescription = map['productdescription'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "shopId": shopId,
        "promotionId": promotionId,
        "scheme": scheme,
        "fromdate": fromdate,
        "todate": todate,
        "productid": productid,
        "productdescription": productdescription,
      };
}
