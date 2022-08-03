import 'dart:ui';
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
              OutlinedButton(
                onPressed: () {},
                child: const Text('cambiar imagen'),
              ),
              const SizedBox(height: 40.0),
              TextField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  labelText: 'Nombre',
                ),
                onChanged: (valor) => setState(() => nombre = valor),
              ),
              const SizedBox(height: 40.0),
              TextField(
                decoration: InputDecoration(
                  labelText: '0',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: fallido == true ? Colors.red : Colors.purple,
                    ),
                  ),
                ),
                onChanged: (valor) => setState(
                  () {
                    setState(
                      () {
                        contador_inicial = valor;
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkFields() {
    try {
      Contador c = Contador(nombre, int.parse(contador_inicial));
      setState(
        () {
          Listado().contadores.add(c);
          fallido = false;
        },
      );
      debugPrint('${c.nombre},${c.cuenta},${c.imagen}');
    } on FormatException {
      setState(
        () {
          fallido = true;
        },
      );
    }
  }
}
