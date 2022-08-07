import 'package:flutter/material.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

class ItemViewer extends StatefulWidget {
  const ItemViewer({Key? key}) : super(key: key);

  @override
  _ItemViewerState createState() => _ItemViewerState();
}

class _ItemViewerState extends State<ItemViewer> {
  Contador c = Listado().contadores[Listado().actual];
  int contador = 1;
  bool numeroInvalido = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(c.nombre!),
      ),
      body: screenLayout(),
    );
  }

  Widget screenLayout() {
    return Container(
      margin: const EdgeInsets.all(45),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(
                c.imagen!,
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              Text(
                c.cuenta!.toString(),
                style: const TextStyle(fontSize: 45),
              ),
              TextField(
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.numbers_rounded,
                    color: Colors.purple,
                  ),
                  labelText: 'Contador',
                  labelStyle: const TextStyle(fontSize: 25),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color:
                          numeroInvalido == true ? Colors.red : Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: numeroInvalido == true
                            ? Colors.red
                            : Colors.purple),
                  ),
                ),
                onChanged: (valor) => checkNumber(valor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      editCounter(false);
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.red,
                    ),
                    iconSize: 85,
                  ),
                  IconButton(
                    onPressed: () {
                      editCounter(true);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.green,
                    ),
                    iconSize: 85,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkNumber(String valor) {
    if (valor == "") {
      setState(() {
        numeroInvalido = false;
        contador = 1;
      });
    } else {
      try {
        int count = int.parse(valor);
        setState(() {
          numeroInvalido = false;
          contador = count;
        });
      } on FormatException {
        setState(() {
          numeroInvalido = true;
        });
      }
    }
  }

  editCounter(bool sumar) {
    if (sumar) {
      setState(() {
        Listado().contadores[Listado().actual].cuenta =
            Listado().contadores[Listado().actual].cuenta! + contador;
      });
    } else {
      setState(() {
        Listado().contadores[Listado().actual].cuenta =
            Listado().contadores[Listado().actual].cuenta! - contador;
        if (Listado().contadores[Listado().actual].cuenta! <= 0) {
          Listado().contadores[Listado().actual].cuenta = 0;
        }
      });
    }
  }
}
