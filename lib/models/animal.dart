class Animal{
  int? id, playerId;
  String? name, code, type, nomenclature, image;

  Animal({this.id, this.playerId, this.name, this.code, this.type, this.nomenclature, this.image});

  factory  Animal.fromJson(Map<String, dynamic> json) {
    return new Animal(
      id : json['id'],
      playerId : json['player_id'],
      name : json['name'],
      code : json['code'],
      type : json['type'],
      nomenclature : json['nomenclature'],
      image : json['image'],
    );
  }

}