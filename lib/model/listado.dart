import 'contador.dart';

class Listado {
  static final Listado _listadoInstance = Listado._internal();
  List<Contador> contadores = [];
  int actual = 0;

  factory Listado() {
    return _listadoInstance;
  }
  Listado._internal();
}
