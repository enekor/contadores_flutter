import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

import 'model/temas.dart';

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
    Orientation orientation = MediaQuery.of(context).orientation;
    return Obx(
      () => Scaffold(
        backgroundColor: Temas().getBackground(),
        appBar: AppBar(
          title:
              Text(c.nombre!, style: TextStyle(color: Temas().getTextColor())),
        ),
        body: Container(
          color: Temas().getBackground(),
          margin: const EdgeInsets.all(20),
          child: screenLayout(orientation),
        ),
      ),
    );
  }

  Widget screenLayout(Orientation o) =>
      o == Orientation.landscape ? horizontalView() : verticalView();

  Widget horizontalView() => Obx(
        () => Center(
          child: SingleChildScrollView(
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Image.network(
                        c.imagen!,
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        c.contador.toString(),
                        style: TextStyle(
                            color: Temas().getTextColor(), fontSize: 45),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.numbers_rounded,
                            color: Colors.purple,
                          ),
                          labelText: 'Contador',
                          labelStyle: TextStyle(
                              color: Temas().getTextColor(), fontSize: 25),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: numeroInvalido == true
                                  ? Colors.red
                                  : Colors.purple,
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
              ],
            ),
          ),
        ),
      );

  Widget verticalView() => Obx(
        () => Center(
          child: Container(
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
                      c.contador.toString(),
                      style: TextStyle(
                          color: Temas().getTextColor(), fontSize: 45),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.numbers_rounded,
                          color: Colors.purple,
                        ),
                        labelText: 'Contador',
                        labelStyle: TextStyle(
                            color: Temas().getTextColor(), fontSize: 25),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(
                            color: numeroInvalido == true
                                ? Colors.red
                                : Colors.purple,
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
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: cambiarInfo,
                      child: Text(
                        c.informacion != ''
                            ? c.informacion!
                            : 'Toca para estalecer informacion del contador',
                        style: TextStyle(
                          color: Temas().getTextColor(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

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
        Listado().contadores[Listado().actual].contador =
            Listado().contadores[Listado().actual].contador! + contador;
      });
    } else {
      setState(
        () {
          Listado().contadores[Listado().actual].contador =
              Listado().contadores[Listado().actual].contador! - contador;
          if (Listado().contadores[Listado().actual].contador! <= 0) {
            Listado().contadores[Listado().actual].contador = 0;
          }
        },
      );
    }
  }

  void cambiarInfo() {
    String texto = '';
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(color: Temas().getBackground(),child: SizedBox(

          height: 400,
          child: Container(
            color: Temas().getBackground(),
            margin: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextFormField(
                      decoration: InputDecoration(

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Temas().getPrimary()),
                        ),
                        focusedBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Temas().getPrimary()),
                        ),
                      ),
                      style: TextStyle(
                        color: Temas().getTextColor(),
                      ),
                      onChanged: (valor) => texto = valor,
                      initialValue: c.informacion,
                      maxLines: null,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            c.informacion = texto;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'guardar',
                          style: TextStyle(color: Temas().getButtonTextColor()),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),);
      },
    );
  }
}
