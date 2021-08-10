import 'package:ctbeca/models/slp.dart';

class Player{
  int? id;
  String? name, phone, email, telegram, urlCodeQr, reference, user, emailGame, passwordGame, wallet, accessToken, tokenFCM;
  List<Slp>? listSlp;

  Player({this.id, this.name, this.email, this.phone, this.telegram, this.urlCodeQr, this.reference, this.user, this.emailGame, this.passwordGame, this.wallet, this.accessToken, this.tokenFCM, this.listSlp});

  factory  Player.fromJson(Map<String, dynamic> json) {
    return new Player(
      id : json['id'],
      name : json['name'],
      email: json['email'],
      phone : json['phone'],
      telegram : json['telegram'],
      urlCodeQr : json['urlCodeQr'],
      reference : json['reference'],
      user : json['user'],
      emailGame : json['emailGame'],
      wallet : json['wallet'],
      listSlp: json['total_s_l_p'] == null ? null : (json['total_s_l_p']as List).map((val) => Slp.fromJson(val)).toList(),
    );
  }

}