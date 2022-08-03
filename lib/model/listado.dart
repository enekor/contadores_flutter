import 'package:flutter/widgets.dart';

import 'contador.dart';

class Listado {
  static Listado? listadoInstance;
  List<Contador> contadores = [];

  static Listado getInstace() {
    listadoInstance ??= Listado();
    return listadoInstance!;
  }

  void addItem(Contador c) {
    contadores.add(c);
    contadores.forEach((e) => debugPrint(e.nombre));
  }

  void editItem(Contador c, int pos) {
    contadores[pos] = c;
  }

  void deleteItem(int pos) {
    contadores.remove(contadores[pos]);
  }
}
