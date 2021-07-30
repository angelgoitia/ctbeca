class User{
  String? accessToken, tokenFCM;

  User({this.accessToken, this.tokenFCM,});

  User.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenFCM = json['tokenFCM'];
  }

}