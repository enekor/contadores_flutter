import 'package:flutter/material.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

class NuevoContador extends StatefulWidget {
  const NuevoContador({Key? key}) : super(key: key);

  @override
  State<NuevoContador> createState() => _NuevoContadorState();
}

class _NuevoContadorState extends State<NuevoContador> {
  String nombre = '';
  String contador_inicial = '0';
  bool fallido = false;
  bool nombreFallido = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Crear nuevo contador',
                style: TextStyle(fontSize: 22, color: Colors.blue),
              ),
              const SizedBox(height: 40.0),
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/16/16642.png',
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 5),
              OutlinedButton(
                onPressed: () {},
                child: const Text('cambiar imagen'),
              ),
              const SizedBox(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.abc_rounded,
                    color: Colors.purple,
                  ),
                  labelText: 'Nombre',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: nombreFallido == true ? Colors.red : Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color:
                            nombreFallido == true ? Colors.red : Colors.purple),
                  ),
                ),
                onChanged: (valor) => setState(() => nombre = valor),
              ),
              const SizedBox(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.numbers_rounded,
                    color: Colors.purple,
                  ),
                  labelText: 'Contador inicial',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: fallido == true ? Colors.red : Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: fallido == true ? Colors.red : Colors.purple),
                  ),
                ),
                onChanged: (valor) => setState(
                  () {
                    setState(
                      () {
                        if (valor == "") {
                          contador_inicial = '0';
                        } else {
                          contador_inicial = valor;
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 40.0),
              OutlinedButton(
                onPressed: () {
                  checkFields();
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkFields() {
    if (nombre != "") {
      nombreFallido = false;
      try {
        Contador c = Contador(nombre, int.parse(contador_inicial));
        setState(
          () {
            succedSnacker();
            Listado().contadores.add(c);
            fallido = false;
          },
        );
        debugPrint('${c.nombre},${c.cuenta},${c.imagen}');
      } on FormatException {
        setState(
          () {
            failSnacker();
            fallido = true;
            contador_inicial = '0';
          },
        );
      }
    } else {
      setState(() {
        nombreFallido = true;
      });
      failSnacker();
    }
  }

  void failSnacker() {
    var mensaje = SnackBar(
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
              'no ha introducido un contador valido',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 100),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(mensaje);
  }

  void succedSnacker() {
    var mensaje = SnackBar(
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
      duration: const Duration(milliseconds: 100),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(mensaje);
  }
}
