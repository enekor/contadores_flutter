import 'package:flutter/material.dart';
import 'package:untitled/item_view.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

var contadoresList = Listado().contadores;

class VerContadores extends StatefulWidget {
  const VerContadores({Key? key}) : super(key: key);

  @override
  _VerContadoresState createState() => _VerContadoresState();
}

class _VerContadoresState extends State<VerContadores> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                child: item(contadoresList[index], index));
          }),
    );
  }

  ClipRRect item(Contador c, int index) => ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Container(
          color: const Color.fromARGB(41, 165, 3, 174),
          child: cardItem(index),
        ),
      );

  Widget cardItem(int index) => GestureDetector(
        onTap: () {
          openItemView(index);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 4, bottom: 4),
              child: Image.network(
                contadoresList[index].imagen!,
                height: 150,
                width: 150,
              ),
            ),
            Column(
              children: [
                Text(
                  contadoresList[index].nombre!,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  contadoresList[index].cuenta!.toString(),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
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
                      iconSize: 50,
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
                      iconSize: 50,
                      hoverColor: const Color.fromARGB(0, 76, 175, 79),
                    ),
                  ],
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(right: 15),
                child: Center(
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
                ))
          ],
        ),
      );

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
        c.cuenta = c.cuenta! + 1;
        Listado().contadores[index] = c;
      });
    } else {
      setState(() {
        if (c.cuenta != 0) {
          c.cuenta = c.cuenta! - 1;
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
