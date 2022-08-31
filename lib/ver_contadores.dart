import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/item_view.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/snackers.dart';
import 'package:untitled/model/temas.dart';

class VerContadores extends StatefulWidget {
  const VerContadores({Key? key, contadores}) : super(key: key);
  VerContadores VerContadoresConstructor(List<Contador> contadores) {
    return const VerContadores();
  }

  @override
  _VerContadoresState createState() => _VerContadoresState();
}

class _VerContadoresState extends State<VerContadores> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: ListView.builder(
                itemCount: Listado().contadores.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 1,
                        top: 1,
                      ),
                      child: item(
                          Listado().contadores[index], index, orientation));
                },
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  childAspectRatio: 8 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemCount: Listado().contadores.length,
              itemBuilder: (BuildContext context, int index) =>
                  item(Listado().contadores[index], index, orientation),
            ),
          );
  }

  Widget item(Contador c, int index, Orientation o) => Obx(
        () => Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: borderGenerator(index, o),
            color: Temas().getSecondary(),
          ),
          child: cardItem(index, o),
        ),
      );

  Widget cardItem(int index, Orientation o) {
    return GestureDetector(
      onTap: () {
        openItemView(index);
      },
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 4, bottom: 4),
                child: Image.network(
                  Listado().contadores[index].imagen!,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(
                    top: Listado().contadores[index].nombre!.length > 10
                        ? 20
                        : 5),
                child: Column(
                  children: [
                    Text(
                      Listado().contadores[index].nombre!,
                      style: TextStyle(
                          color: Temas().getTextColor(),
                          fontSize:
                              Listado().contadores[index].nombre!.length > 10
                                  ? 15
                                  : 30),
                    ),
                    Text(
                      Listado().contadores[index].contador.toString(),
                      style: TextStyle(
                          color: Temas().getTextColor(), fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            editarContador(
                                false, Listado().contadores[index], index);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          iconSize: 40,
                          hoverColor: const Color.fromARGB(0, 76, 175, 79),
                        ),
                        IconButton(
                          onPressed: () {
                            editarContador(
                                true, Listado().contadores[index], index);
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          ),
                          iconSize: 40,
                          hoverColor: const Color.fromARGB(0, 76, 175, 79),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(
                    right: 15, top: o == Orientation.landscape ? 30 : 0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(Snacker().confirmSnack(
                              Listado().contadores[index],
                              context,
                              borrarItem)),
                      icon: const Icon(
                        Icons.recycling_rounded,
                        color: Colors.deepOrange,
                      ),
                      iconSize: 30,
                      hoverColor: const Color.fromARGB(0, 76, 175, 79),
                    ),
                    IconButton(
                      onPressed: () {
                        uploadItem(Listado().contadores[index], index);
                      },
                      icon: const Icon(
                        Icons.upload_rounded,
                        color: Colors.deepOrange,
                      ),
                      iconSize: 30,
                      hoverColor: const Color.fromARGB(0, 76, 175, 79),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void borrarItem(Contador c) => setState(() => Listado().contadores.remove(c));

  void editarContador(bool suma, Contador c, int index) {
    if (suma) {
      setState(() {
        c.contador = c.contador! + 1;
        Listado().contadores[index] = c;
      });
    } else {
      setState(() {
        if (c.contador != 0) {
          c.contador = c.contador! - 1;
          Listado().contadores[index] = c;
        }
      });
    }
  }

  openItemView(int index) {
    Listado().actual = index;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => const ItemViewer()),
    );
  }

  uploadItem(Contador c, int index) async {
    late var uri;
    if (Platform.isAndroid) {
      uri = Uri.parse('http://192.168.1.138:7777/contadores/add');
    } else {
      uri = Uri.parse('http://localhost:7777/contadores/add');
    }

    try {
      var ans = await http.post(
        uri,
        body: jsonEncode(c),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      debugPrint(jsonEncode(c));

      Contador ansContador = Contador.fromJson(jsonDecode(ans.body));
      Listado().contadores[index].id = ansContador.id!;

      showSnack(
        Snacker().simpleSnack(
          'Contador subido correctamente',
          const Color.fromARGB(255, 2, 204, 42),
          const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
    } catch (e) {
      showSnack(
        Snacker().simpleSnack(
          'Ha habido un problema con la red, vuelve a intentarlo mas tarde',
          const Color.fromARGB(255, 208, 11, 0),
          const Icon(
            Icons.warning_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      );
    }
  }

  showSnack(SnackBar snack) {
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  BorderRadiusGeometry borderGenerator(int pos, Orientation o) {
    debugPrint(pos.toString());
    if (o == Orientation.landscape || Listado().contadores.length == 1) {
      return BorderRadius.circular(25);
    } else {
      if (pos == 0) {
        return const BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25));
      } else if (pos == Listado().contadores.length - 1) {
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
}
