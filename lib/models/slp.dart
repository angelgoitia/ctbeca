class Slp{
  int? id, playerId, total, daily;
  String? createdAt;

  Slp({this.id, this.playerId, this.total, this.daily, this.createdAt,});

  factory  Slp.fromJson(Map<String, dynamic> json) {
    return new Slp(
      id : json['id'],
      playerId : json['playerId'],
      total : json['total'],
      daily : json['daily'],
      createdAt : json['created_at'],
    );
  }

}