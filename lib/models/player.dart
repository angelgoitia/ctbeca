import 'package:ctbeca/models/slp.dart';

class Player{
  int? id;
  String? name, phone, email, telegram, urlCodeQr, reference, emailGame, wallet, accessToken, tokenFCM;
  List<Slp>? listSlp;

  Player({this.id, this.name, this.email, this.phone, this.telegram, this.urlCodeQr, this.reference, this.emailGame, this.wallet, this.accessToken, this.tokenFCM, this.listSlp});

  factory  Player.fromJson(Map<String, dynamic> json) {
    return new Player(
      id : json['id'],
      name : json['name'],
      email: json['email'],
      phone : json['phone'],
      telegram : json['telegram'],
      urlCodeQr : json['urlCodeQr'],
      reference : json['reference'],
      emailGame : json['emailGame'],
      wallet : json['wallet'],
      accessToken : json['access_token'],
      tokenFCM : json['tokenFCM'],
      listSlp: json['total_s_l_p'] == null ? null : (json['total_s_l_p']as List).map((val) => Slp.fromJson(val)).toList(),
    );
  }

}