class Admin{
  String? accessToken, tokenFCM;

  Admin({this.accessToken, this.tokenFCM,});

  Admin.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenFCM = json['tokenFCM'];
  }

}