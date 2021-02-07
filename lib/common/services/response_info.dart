class ResponseInfo {
  final int responseCode;
  final bool result;
  final String responseMsg;

  const ResponseInfo({
    this.responseCode,
    this.result,
    this.responseMsg,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      responseCode: int.parse(json['ResponseCode']),
      result: json['Result'].toLowerCase() == 'true',
      responseMsg: json['ResponseMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ResponseCode'] = this.responseCode;
    data['Result'] = this.result;
    data['ResponseMsg'] = this.responseMsg;
    return data;
  }
}
