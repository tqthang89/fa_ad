import 'package:flutter/cupertino.dart';

class CreateShopModel{
  String merchantName;
  TextEditingController merchantNameController;
  String phoneNumber;
  TextEditingController phoneController;
  int provinceId;
  int districtId;

  int townId;

  String addressline;
  TextEditingController addresslineController;

  int areaDisplay;
  String itemDisplay;
  TextEditingController itemDisplayController;
  String typeDisplay;
  TextEditingController typeDisplayController;
  String revenue;
  TextEditingController revenueController;
  String photo;
  double latitude;
  double longitude;

  CreateShopModel({this.merchantName, this.phoneNumber, this.provinceId, this.districtId,this.areaDisplay,this.typeDisplay,this.revenue,this.photo,this.latitude,this.longitude,this.townId,this.addressline});

  CreateShopModel.fromJson(Map<String, dynamic> json) {
    merchantName = json['merchantName'];
    phoneNumber = json['phoneNumber'];
    provinceId = json['provinceId'];
    districtId = json['districtId'];
    areaDisplay = json['areaDisplay'];
    itemDisplay = json['itemDisplay'];
    typeDisplay = json['typeDisplay'];
    revenue = json['revenue'];
    photo = json['photo'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    townId = json['townId'];
    addressline = json['addressline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantName'] = this.merchantName;
    data['phoneNumber'] = this.phoneNumber;
    data['provinceId'] = this.provinceId;
    data['districtId'] = this.districtId;
    data['areaDisplay'] = this.areaDisplay;
    data['itemDisplay'] = this.itemDisplay;
    data['typeDisplay'] = this.typeDisplay;
    data['revenue'] = this.revenue;
    data['photo'] = this.photo;

    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    data['townId'] = this.townId;
    data['addressline'] = this.addressline;

    return data;
  }
}