class Slp{
  int? id, playerId, total, daily;
  String? createdAt, date;

  Slp({this.id, this.playerId, this.total, this.daily, this.createdAt, this.date});

  factory  Slp.fromJson(Map<String, dynamic> json) {
    return new Slp(
      id : json['id'],
      playerId : json['player_id'],
      total : json['total'],
      daily : json['daily'],
      createdAt : json['created_at'],
      date : json['date'],
    );
  }

}