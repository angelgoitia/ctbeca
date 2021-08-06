import 'package:ctbeca/models/slp.dart';

class Player{
  int? id;
  String? name, phone, telegram, urlcodeQr, reference, accessToken, tokenFCM;
  List<Slp>? listSlp;

  Player({this.id, this.name, this.phone, this.telegram, this.urlcodeQr, this.reference, this.accessToken, this.tokenFCM, this.listSlp});

  factory  Player.fromJson(Map<String, dynamic> json) {
    return new Player(
      id : json['id'],
      name : json['name'],
      phone : json['phone'],
      telegram : json['telegram'],
      urlcodeQr : json['urlcodeQr'],
      reference : json['reference'],
      accessToken : json['access_token'],
      tokenFCM : json['tokenFCM'],
      listSlp: json['total_s_l_p'] == null ? null : (json['total_s_l_p']as List).map((val) => Slp.fromJson(val)).toList(),
    );
  }

}