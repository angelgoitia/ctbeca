class Admin{
  int? id;
  String? accessToken, tokenFCM, name;

  Admin({this.id, this.accessToken, this.tokenFCM, this.name});

  factory  Admin.fromJson(Map<String, dynamic> json) {
    return new Admin(
      id: json['id'],
      accessToken : json['access_token'],
      tokenFCM : json['tokenFCM'],
      name : json['name'],
    );
  }

}