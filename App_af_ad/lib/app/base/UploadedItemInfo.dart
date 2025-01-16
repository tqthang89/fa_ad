class UploadedItemInfo {
  String itemName;
  int itemId;

  Map<String, dynamic> toMap() => {
        "itemName": itemName,
        "itemId": itemId,
      };

  @override
  UploadedItemInfo.fromMap(Map<String, dynamic> map) {
    itemName = map["itemName"];
    itemId = map["itemId"];
  }
}
