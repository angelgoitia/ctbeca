class Admin{
  int? id;
  String? accessToken, tokenFCM, name, nameGroup;

  Admin({this.id, this.accessToken, this.tokenFCM, this.name, this.nameGroup});

  factory  Admin.fromJson(Map<String, dynamic> json) {
    return new Admin(
      id: json['id'],
      tokenFCM : json['tokenFCM'],
      name : json['name'],
      nameGroup : json['nameGroup'],
    );
  }

}