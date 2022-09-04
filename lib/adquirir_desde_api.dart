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
  bool borrados = false;
  String apiCall = 'active';

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
                  const SizedBox(width: 15),
                  IconButton(
                      onPressed: changeItemType,
                      icon: Icon(borrados == true
                          ? Icons.delete_sweep_rounded
                          : Icons.extension_sharp))
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
      url = Uri.parse('http://192.168.1.138:7777/contadores/$apiCall');
    } else {
      url = Uri.parse('http://localhost:7777/contadores/$apiCall');
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
        return item(contadores[index], index);
      },
    );
  }

  Widget item(Contador c, int index) => Obx(
        () => Container(
          margin: const EdgeInsets.only(bottom: 4, right: 10, left: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: borderGenerator(index),
            color: Temas().getSecondary(),
          ),
          child: cardItem(c),
        ),
      );

  Widget cardItem(Contador c) {
    return Obx(
      () => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 4, bottom: 4),
                child: Image.network(
                  c.imagen!,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(top: c.nombre!.length > 10 ? 20 : 5),
                child: Column(
                  children: [
                    Text(
                      c.nombre!,
                      style: TextStyle(
                          color: Temas().getTextColor(),
                          fontSize: c.nombre!.length > 10 ? 15 : 30),
                    ),
                    Text(
                      c.contador.toString(),
                      style: TextStyle(
                          color: Temas().getTextColor(), fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 15,
                ),
                child: c.activo == true
                    ? Column(
                        children: [
                          IconButton(
                            onPressed: () => deleteContador(c),
                            icon: const Icon(
                              Icons.recycling_rounded,
                              color: Colors.deepOrange,
                            ),
                            iconSize: 30,
                            hoverColor: const Color.fromARGB(0, 76, 175, 79),
                          ),
                          IconButton(
                            onPressed: () => addItemToList(c),
                            icon: const Icon(
                              Icons.playlist_add_check_rounded,
                              color: Colors.deepOrange,
                            ),
                            iconSize: 30,
                            hoverColor: const Color.fromARGB(0, 76, 175, 79),
                          ),
                        ],
                      )
                    : Center(
                        child: IconButton(
                            onPressed: () => restoreContador(c),
                            icon: const Icon(Icons.restore_from_trash_rounded)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BorderRadiusGeometry borderGenerator(int pos) {
    if (contadores.length == 1) {
      return BorderRadius.circular(25);
    } else {
      if (pos == 0) {
        return const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25));
      } else if (pos == contadores.length - 1) {
        return const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5));
      } else {
        return BorderRadius.circular(5);
      }
    }
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

  void restoreContador(Contador c) async {
    late var url;
    if (Platform.isAndroid) {
      url = Uri.parse('http://192.168.1.138:7777/contadores/restore/${c.id}');
    } else {
      url = Uri.parse("http://localhost:7777/contadores/restore/${c.id}");
    }

    var ans = await http.put(url);

    if (ans.statusCode == 202) {
      showSnacker(Snacker().simpleSnack(
          'Restaurado con exito',
          Colors.green.shade300,
          const Icon(Icons.check_circle_outline_rounded)));
    } else {
      showSnacker(Snacker().simpleSnack(
          'Hubo un problema al restaurar, pruebe mas tarde',
          Colors.red.shade600,
          const Icon(Icons.close_rounded)));
    }

    setState(() {
      contadores.remove(c);
    });
  }

  changeItemType() {
    setState(() {
      borrados = !borrados;
      apiCall = borrados == true ? 'deleted' : 'active';
    });

    showSnacker(
      Snacker().simpleSnack(
        borrados == true ? 'Mostrando borrados' : 'Mostrando activos',
        const Color.fromARGB(255, 231, 176, 241),
        Icon(borrados == true
            ? Icons.delete_sweep_rounded
            : Icons.extension_sharp),
      ),
    );
  }
}
