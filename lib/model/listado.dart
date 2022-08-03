import 'package:flutter/widgets.dart';
import 'contador.dart';

class Listado {
  static final Listado _listadoInstance = Listado._internal();
  List<Contador> contadores = [];

  factory Listado() {
    return _listadoInstance;
  }
  Listado._internal();
}
