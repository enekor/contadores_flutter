import 'package:flutter/material.dart';

import 'contador.dart';

class Snacker {
  SnackBar confirmSnack(Contador c, BuildContext context, borrarItem) =>
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Borrar elemento ${c.nombre}?'),
            IconButton(
              onPressed: () {
                borrarItem(c);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(
                Icons.cancel_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );

  SnackBar simpleSnack(String mensaje, Color color, Icon icono) => SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: icono),
            Expanded(
              flex: 7,
              child: Text(
                mensaje,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      );

  SnackBar failSnacker() => SnackBar(
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.warning_rounded,
                color: Colors.white,
                size: 68,
              ),
              Text(
                'No ha introducido un contador valido',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        duration: const Duration(milliseconds: 300),
        backgroundColor: Colors.red,
      );

  SnackBar succedSnacker() => SnackBar(
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 68,
              ),
              Text(
                'Contador guardado',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        duration: const Duration(milliseconds: 300),
        backgroundColor: Colors.green,
      );
}
