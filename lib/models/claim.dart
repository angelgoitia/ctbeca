class Claim{
  String? date;
  int? id, playerId, total;
  double? totalManager, totalPlayer;

  Claim({this.id, this.playerId, this.date, this.total, this.totalManager, this.totalPlayer});

  factory  Claim.fromJson(Map<String, dynamic> json) {
    return new Claim(
      id : json['id'],
      playerId : json['player_id'],
      date : json['date'],
      total : json['total'],
      totalManager : json['totalManager'].toDouble(),
      totalPlayer : json['totalPlayer'].toDouble(),
    );
  }

}