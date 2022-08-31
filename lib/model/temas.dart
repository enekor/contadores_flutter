import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Temas {
  static final Temas _temasInstance = Temas._internal();

  RxInt actual = 1.obs;

  factory Temas() {
    return _temasInstance;
  }
  Temas._internal();

  MaterialColor getPrimary() {
    if (actual.value == 1) {
      return TemaClaro().primario;
    } else if (actual.value == 2) {
      return TemaOscuro().primario;
    } else {
      return TemaCustom().primario;
    }
  }

  Color getSecondary() {
    if (actual.value == 1) {
      return TemaClaro().secundario;
    } else if (actual.value == 2) {
      return TemaOscuro().secundario;
    } else {
      return TemaCustom().secundario;
    }
  }

  Color getBackground() {
    if (actual.value == 1) {
      return TemaClaro().fondo;
    } else if (actual.value == 2) {
      return TemaOscuro().fondo;
    } else {
      return TemaCustom().fondo;
    }
  }

  Color getTextColor() {
    if (actual.value == 1) {
      return TemaClaro().texto;
    } else if (actual.value == 2) {
      return TemaOscuro().texto;
    } else {
      return TemaCustom().texto;
    }
  }
}

class TemaClaro {
  static final TemaClaro _temaClaroInstance = TemaClaro._internal();

  MaterialColor primario = Colors.purple;
  Color secundario = const Color.fromARGB(255, 222, 155, 227);
  Color fondo = Colors.white;
  Color texto = Colors.black54;

  factory TemaClaro() {
    return _temaClaroInstance;
  }

  TemaClaro._internal();
}

class TemaOscuro {
  static final TemaOscuro _temaOscuroInstance = TemaOscuro._internal();

  MaterialColor primario = Colors.lightBlue;
  Color secundario = const Color.fromARGB(255, 232, 129, 238);
  Color fondo = const Color.fromARGB(255, 0, 0, 24);
  Color texto = Colors.white60;

  factory TemaOscuro() {
    return _temaOscuroInstance;
  }

  TemaOscuro._internal();
}

class TemaCustom {
  static final TemaCustom _temaCustomInstance = TemaCustom._internal();

  MaterialColor primario = Colors.green;
  Color secundario = const Color.fromARGB(250, 51, 228, 255);
  Color fondo = const Color.fromARGB(255, 255, 255, 255);
  Color texto = Colors.red.shade400;

  factory TemaCustom() {
    return _temaCustomInstance;
  }

  TemaCustom._internal();
}
