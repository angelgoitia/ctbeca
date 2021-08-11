class Admin{
  String? accessToken, tokenFCM;

  Admin({this.accessToken, this.tokenFCM,});

  factory  Admin.fromJson(Map<String, dynamic> json) {
    return new Admin(
      accessToken : json['access_token'],
      tokenFCM : json['tokenFCM'],
    );
  }

}