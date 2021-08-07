class History{
  String? total, fecha;

  History({this.total, this.fecha,});

  History.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    fecha = json['fecha'];
  }

}