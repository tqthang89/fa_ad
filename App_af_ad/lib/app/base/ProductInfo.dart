import 'package:syngentaaudit/app/base/BaseInfo.dart';

class ProductInfo extends BaseInfo {
  int productId;
  String productName;
  String package;
  int catId;
  int rate;
  String segment2;
  String segment;
  String segment4;
  int sortlist;
  String keyBrand;
  String brand;
  String milkPowder;
  String photo;

  ProductInfo(
      {this.productId,
      this.productName,
      this.package,
      this.catId,
      this.rate,
      this.segment2,
      this.segment,
      this.segment4,
      this.sortlist,
      this.photo,
      this.brand,
      this.keyBrand,
      this.milkPowder});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    package = json['package'];
    catId = json['catId'];
    rate = json['rate'];
    segment2 = json['segment2'];
    segment = json['segment'];
    segment4 = json['segment4'];
    sortlist = json['sortlist'];
    photo = json['photo'];
    brand = json['brand'];
    keyBrand = json['keyBrand'];
    milkPowder = json['milkPowder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['package'] = this.package;
    data['catId'] = this.catId;
    data['rate'] = this.rate;
    data['segment2'] = this.segment2;
    data['segment'] = this.segment;
    data['segment4'] = this.segment4;
    data['sortlist'] = this.sortlist;
    data['photo'] = this.photo;
    data['brand'] = this.brand;
    data['keyBrand'] = this.keyBrand;
    data['milkPowder'] = this.milkPowder;
    return data;
  }

  @override
  ProductInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    productId = map['productId'];
    productName = map['productName'];
    package = map['package'];
    catId = map['catId'];
    rate = map['rate'];
    segment2 = map['segment2'];
    segment = map['segment'];
    segment4 = map['segment4'];
    sortlist = map['sortlist'];
    photo = map['photo'];
    brand = map['brand'];
    keyBrand = map['keyBrand'];
    milkPowder = map['milkPowder'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "productId": productId,
        "productName": productName,
        "package": package,
        "catId": catId,
        "rate": rate,
        "segment2": segment2,
        "segment": segment,
        "segment4": segment4,
        "sortlist": sortlist,
        "photo": photo,
        "brand": brand,
        "keyBrand": keyBrand,
        "milkPowder": milkPowder
      };
}
