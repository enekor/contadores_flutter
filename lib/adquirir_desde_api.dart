import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/listado.dart';
import 'package:untitled/model/snackers.dart';
import 'model/contador.dart';

class AdquirirDesdeApi extends StatefulWidget {
  const AdquirirDesdeApi({Key? key}) : super(key: key);

  @override
  _AdquirirDesdeApiState createState() => _AdquirirDesdeApiState();
}

class _AdquirirDesdeApiState extends State<AdquirirDesdeApi> {
  List<Contador> contadores = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: loadItems,
                  icon: const Icon(Icons.download_rounded),
                  hoverColor: const Color.fromARGB(0, 76, 175, 79),
                ),
                TextButton(
                  onPressed: loadItems,
                  child: const Text('Cargar desde la api'),
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
    );
  }

  loadItems() async {
    late var url;
    if (Platform.isAndroid) {
      url = Uri.parse('http://192.168.1.138:7777/contadores/all');
    } else {
      url = Uri.parse('http://localhost:7777/contadores/all');
    }
    try {
      var ans = await http.get(url);

      if (ans.statusCode == 200 || ans.statusCode == 300) {
        debugPrint('tiene contendo');
        ContadoresBD contans = ContadoresBD.fromJson(jsonDecode(ans.body));

        setState(() {
          contadores = contans.content!;
        });

        debugPrint(contadores.length.toString());
      } else {
        debugPrint('no tiene contenido');
        showSnacker(
          Snacker().simpleSnack(
            'No hay contadores en la base de datos',
            Colors.red,
            const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        );

        setState(() {
          contadores = [];
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
    return Center(
      child: Card(
        color: const Color.fromARGB(113, 90, 121, 137),
        borderOnForeground: true,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 20,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Image.network(c.imagen!, width: 130, height: 130),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Text(c.nombre!),
                  Text(c.contador!.toString()),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  addItemToList(c);
                },
                icon: const Icon(Icons.add_task_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }

  showSnacker(SnackBar snacker) {
    ScaffoldMessenger.of(context).showSnackBar(snacker);
  }

  void addItemToList(Contador c) {
    setState(() {
      Listado().contadores.add(c);
      contadores.remove(c);
    });
    showSnacker(
      Snacker().simpleSnack(
        'Contador guardado en local',
        Colors.lightGreenAccent,
        const Icon(
          Icons.warning_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
