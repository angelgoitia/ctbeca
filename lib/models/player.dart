import 'package:ctbeca/models/animal.dart';
import 'package:ctbeca/models/slp.dart';

class Player{
  int? id;
  String? name, phone, email, telegram, urlCodeQr, reference, emailGame, passwordGame, wallet, accessToken, tokenFCM, dateClaim;
  List<Slp>? listSlp;
  List<Animal>? listAnimals;

  Player({this.id, this.name, this.email, this.phone, this.telegram, this.urlCodeQr, this.reference, this.emailGame, this.passwordGame, this.wallet, this.accessToken, this.tokenFCM, this.listSlp, this.listAnimals, this.dateClaim});

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
      dateClaim: json['dateClaim'],
      listSlp: json['total_s_l_p'] == null ? null : (json['total_s_l_p']as List).map((val) => Slp.fromJson(val)).toList(),
      listAnimals: json['animals'] == null ? null : (json['animals']as List).map((val) => Animal.fromJson(val)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'telegram': telegram,
    'urlCodeQr': urlCodeQr,
    'reference': reference,
    'emailGame': emailGame,
    'dateClaim': dateClaim,
    'wallet': wallet,
  };

}