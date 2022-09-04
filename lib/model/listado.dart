import 'contador.dart';

class Listado {
  static final Listado _listadoInstance = Listado._internal();
  List<Contador> contadores = [];
  int actual = 0;

  factory Listado() {
    return _listadoInstance;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (contadores != null) {
      data['contadores'] = contadores.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Listado._internal();
}

class ListadoFromJson {
  List<Contador> contadores = [];
  ListadoFromJson({this.contadores = const []});

  ListadoFromJson.fromJson(Map<String, dynamic> json) {
    if (json['contadores'] != null) {
      contadores = <Contador>[];
      json['contadores'].forEach((v) {
        contadores.add(Contador.fromJson(v));
      });
    }
  }
}
