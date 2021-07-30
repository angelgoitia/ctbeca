class Player{
  int? id;
  String? name, phone, telegram, urlcodeQr, reference, accessToken, tokenFCM;

  Player({this.id, this.name, this.phone, this.telegram, this.urlcodeQr, this.reference, this.accessToken, this.tokenFCM,});

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    telegram = json['telegram'];
    urlcodeQr = json['urlcodeQr'];
    reference = json['reference'];
    accessToken = json['accessToken'];
    tokenFCM = json['tokenFCM'];
  }

}