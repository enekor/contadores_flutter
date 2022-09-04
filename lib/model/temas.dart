import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
      return TemaCustom().primario.value;
    }
  }

  Color getSecondary() {
    if (actual.value == 1) {
      return TemaClaro().secundario;
    } else if (actual.value == 2) {
      return TemaOscuro().secundario;
    } else {
      return TemaCustom().secundario.value;
    }
  }

  Color getBackground() {
    if (actual.value == 1) {
      return TemaClaro().fondo;
    } else if (actual.value == 2) {
      return TemaOscuro().fondo;
    } else {
      return TemaCustom().fondo.value;
    }
  }

  Color getTextColor() {
    if (actual.value == 1) {
      return TemaClaro().texto;
    } else if (actual.value == 2) {
      return TemaOscuro().texto;
    } else {
      return TemaCustom().texto.value;
    }
  }

  Color getButtonTextColor() {
    if (actual.value == 1) {
      return TemaClaro().buttonTextColor;
    } else if (actual.value == 2) {
      return TemaOscuro().buttonTextColor;
    } else {
      return TemaCustom().buttonTextColor.value;
    }
  }
}

class TemaClaro {
  static final TemaClaro _temaClaroInstance = TemaClaro._internal();

  MaterialColor primario = Colors.purple;
  Color secundario = const Color.fromARGB(255, 222, 155, 227);
  Color fondo = Colors.white;
  Color texto = Colors.black54;
  Color buttonTextColor = Colors.white;

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
  Color buttonTextColor = Colors.black;

  factory TemaOscuro() {
    return _temaOscuroInstance;
  }

  TemaOscuro._internal();
}

class TemaCustom {
  static final TemaCustom _temaCustomInstance = TemaCustom._internal();

  Rx<MaterialColor> primario = Colors.green.obs;
  Rx<Color> secundario = const Color.fromARGB(250, 51, 228, 255).obs;
  Rx<Color> fondo = const Color.fromARGB(255, 255, 255, 255).obs;
  Rx<Color> texto = Colors.red.shade400.obs;
  Rx<Color> buttonTextColor = Colors.white.obs;

  factory TemaCustom() {
    return _temaCustomInstance;
  }

  TemaCustom._internal();

  Widget changeColors(BuildContext context) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => ElevatedButton(
                onPressed: () => openDialog(
                    chooseColor(
                        (color) => TemaCustom().secundario.value = color,
                        'Color secundario',
                        TemaCustom().secundario.value),
                    context),
                child: Text(
                  'Secundario',
                  style: TextStyle(color: TemaCustom().secundario.value),
                ),
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () => openDialog(
                    chooseColor((color) => TemaCustom().texto.value = color,
                        'Color de texto', TemaCustom().texto.value),
                    context),
                child: Text('Texto',
                    style: TextStyle(color: TemaCustom().texto.value)),
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () => openDialog(
                    chooseColor(
                        (color) => TemaCustom().buttonTextColor.value = color,
                        'Color de texto de botones',
                        TemaCustom().buttonTextColor.value),
                    context),
                child: Text('Botones',
                    style:
                        TextStyle(color: TemaCustom().buttonTextColor.value)),
              ),
            ),
          ],
        ),
      );

  Widget chooseColor(onClick, String texto, Color color) => Column(
        children: [
          Text(texto),
          ColorPicker(pickerColor: color, onColorChanged: onClick)
        ],
      );

  openDialog(Widget colorChooser, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(''),
        content: colorChooser,
      ),
    );
  }
}
