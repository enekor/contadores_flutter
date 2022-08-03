import 'package:flutter/widgets.dart';

class Contador {
  String? nombre;
  int? cuenta;
  String? imagen;

  Contador(nombre, [cuenta, imagen]) {
    cuenta ??= 0;
    imagen ??= 'https://cdn-icons-png.flaticon.com/512/16/16642.png';

    debugPrint(nombre);
  }
}
