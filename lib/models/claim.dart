class Claim{
  String? date;
  int? id, playerId, total, totalManager, totalPlayer;

  Claim({this.id, this.playerId, this.date, this.total, this.totalManager, this.totalPlayer});

  factory  Claim.fromJson(Map<String, dynamic> json) {
    return new Claim(
      id : json['id'],
      playerId : json['player_id'],
      date : json['date'],
      total : json['total'],
      totalManager : json['totalManager'],
      totalPlayer : json['totalPlayer'],
    );
  }

}