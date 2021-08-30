class Slp{
  int? id, playerId, total, daily;
  String? createdAt, date;
  double? totalManager;

  Slp({this.id, this.playerId, this.total, this.daily, this.totalManager, this.createdAt, this.date});

  factory  Slp.fromJson(Map<String, dynamic> json) {
    return new Slp(
      id : json['id'],
      playerId : json['player_id'],
      total : json['total'],
      daily : json['daily'],
      totalManager : json['totalManager'].toDouble(),
      createdAt : json['created_at'],
      date : json['date'],
    );
  }

}