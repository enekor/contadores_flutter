import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/listado.dart';
import 'package:untitled/model/snackers.dart';
import 'model/contador.dart';
import 'model/temas.dart';

class AdquirirDesdeApi extends StatefulWidget {
  const AdquirirDesdeApi({Key? key}) : super(key: key);

  @override
  _AdquirirDesdeApiState createState() => _AdquirirDesdeApiState();
}

class _AdquirirDesdeApiState extends State<AdquirirDesdeApi> {
  List<Contador> contadores = [];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: loadItems,
                    icon: Icon(
                      Icons.download_rounded,
                      color: Temas().getTextColor(),
                    ),
                    hoverColor: const Color.fromARGB(0, 76, 175, 79),
                  ),
                  TextButton(
                    onPressed: loadItems,
                    child: Text(
                      'Cargar desde la api',
                      style: TextStyle(
                        color: Temas().getTextColor(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 9,
              child: Center(
                child: lista(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadItems() async {
    late var url;
    if (Platform.isAndroid) {
      url = Uri.parse('http://192.168.1.138:7777/contadores/active');
    } else {
      url = Uri.parse('http://localhost:7777/contadores/active');
    }
    try {
      var ans = await http.get(url);

      ContadoresBD contans = ContadoresBD.fromJson(jsonDecode(ans.body));

      if (contans.content!.isEmpty) {
        showSnacker(
          Snacker().simpleSnack(
            "No hay contadores en la base de datos",
            const Color.fromARGB(255, 231, 176, 241),
            const Icon(
              Icons.layers_clear_rounded,
              color: Colors.blueGrey,
            ),
          ),
        );
      } else {
        setState(() {
          contadores = contans.content!;
        });
      }
    } catch (e) {
      showSnacker(
        Snacker().simpleSnack(
          'Ha habido un problema con la red, vuelve a intentarlo mas tarde',
          Colors.red,
          const Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
    }
  }

  Widget lista() {
    return ListView.builder(
      itemCount: contadores.length,
      itemBuilder: (BuildContext context, int index) {
        return item(contadores[index]);
      },
    );
  }

  Widget item(Contador c) {
    return Obx(
      () => Center(
        child: Card(
          color: const Color.fromARGB(112, 180, 194, 201),
          borderOnForeground: true,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 10,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(c.imagen!, width: 70, height: 70),
                      Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Text(
                              c.nombre!,
                              style: TextStyle(
                                fontSize: 30,
                                color: Temas().getTextColor(),
                              ),
                            ),
                            Text(
                              c.contador!.toString(),
                              style: TextStyle(
                                  color: Temas().getTextColor(), fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => deleteContador(c),
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.redAccent,
                        ),
                      ),
                      IconButton(
                        onPressed: () => addItemToList(c),
                        icon: const Icon(
                          Icons.add_task_rounded,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSnacker(SnackBar snacker) {
    ScaffoldMessenger.of(context).showSnackBar(snacker);
  }

  void addItemToList(Contador c) {
    var exist = Listado().contadores.firstWhere((element) => element.id == c.id,
        orElse: () => Contador(nombre: null));
    if (exist.nombre == null) {
      Listado().contadores.add(c);
      showSnacker(Snacker().simpleSnack("Contador agregado correctamente",
          Colors.green, const Icon(Icons.check_rounded)));
      setState(() => contadores.remove(c));
    } else {
      showSnacker(Snacker().simpleSnack(
          'Contador existente en local',
          const Color.fromARGB(255, 231, 176, 241),
          const Icon(Icons.format_line_spacing_rounded)));
    }
  }

  void deleteContador(Contador c) async {
    late var url;
    if (Platform.isAndroid) {
      url = Uri.parse('http://192.168.1.138:7777/contadores/delete/${c.id}');
    } else {
      url = Uri.parse("http://localhost:7777/contadores/delete/${c.id}");
    }
    var ans = await http.delete(url);

    if (ans.statusCode == 204) {
      setState(() => contadores.remove(c));
      showSnacker(Snacker().simpleSnack('Contador borrado con exito',
          Colors.green, const Icon(Icons.check_rounded)));
    } else {
      showSnacker(Snacker().simpleSnack(
          'Ha habido un problema, vuelve a intentarlo mas tarde',
          Colors.red,
          const Icon(Icons.warning_amber_rounded)));
    }
  }
}
