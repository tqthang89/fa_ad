import 'package:syngentaaudit/app/base/BaseInfo.dart';

class CoinCollectInfo extends BaseInfo {
  int shopId;
  String month;
  int coins;
  int quarter;

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "ShopId": shopId,
        "Month": month,
        "Coins": coins,
        "Quarter": quarter,
      };

  CoinCollectInfo.fromJson(Map<String, dynamic> json) {
    rowId = json['RowId'];
    shopId = json['ShopId'];
    month = json['Month'];
    coins = json['Coins'];
    quarter = json['Quarter'];
  }

  @override
  CoinCollectInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    shopId = map["shopId"];
    month = map["month"];
    coins = map["coins"];
    quarter = map["quarter"];
  }
}
