class CreateShopInfo{
  String group;
  String title;
  String type;
  String img;

  CreateShopInfo({this.group, this.title, this.type, this.img});

  CreateShopInfo.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    title = json['title'];
    type = json['type'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['title'] = this.title;
    data['type'] = this.type;
    data['img'] = this.img;
    return data;
  }
}