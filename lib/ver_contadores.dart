import 'package:flutter/material.dart';
import 'package:untitled/item_view.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

late List<Contador> contadoresList;

class VerContadores extends StatefulWidget {
  const VerContadores({Key? key, contadores}) : super(key: key);
  VerContadores VerContadoresConstructor(List<Contador> contadores) {
    contadoresList = contadores;
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
        ? Center(
            child: ListView.builder(
              itemCount: Listado().contadores.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 1,
                      top: 20,
                    ),
                    child:
                        item(Listado().contadores[index], index, orientation));
              },
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
                  item(contadoresList[index], index, orientation),
            ),
          );
  }

  Widget item(Contador c, int index, Orientation o) => Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: const Color.fromARGB(41, 165, 3, 174),
        ),
        child: cardItem(index, o),
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
                          fontSize:
                              Listado().contadores[index].nombre!.length > 10
                                  ? 15
                                  : 30),
                    ),
                    Text(
                      Listado().contadores[index].contador.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            editarContador(false, contadoresList[index], index);
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
                            editarContador(true, contadoresList[index], index);
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
                        onPressed: () {
                          snacker(contadoresList[index]);
                        },
                        icon: const Icon(
                          Icons.recycling_rounded,
                          color: Colors.deepOrange,
                        ),
                        iconSize: 30,
                        hoverColor: const Color.fromARGB(0, 76, 175, 79)),
                    const Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
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

  void snacker(Contador c) {
    var mensaje = SnackBar(
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

    ScaffoldMessenger.of(context).showSnackBar(mensaje);
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
}
