class HttpResponseMessage {
  int statusCode;
  Object content;
  int totalRaw;
  HttpResponseMessage({this.statusCode, this.content, this.totalRaw});
  HttpResponseMessage.fromJson(Map<String, dynamic> json) {
    statusCode = json["StatusCode"];
    content = json["Content"];
    totalRaw = json["totalRaw"];
  }
}
