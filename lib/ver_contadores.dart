import 'package:flutter/material.dart';
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
          itemBuilder: (BuildContext context, int index) =>
              cardItem(Listado().contadores[index], index)),
    );
  }

  ListTile cardItem(Contador c, int index) {
    bool enBorrado = false;
    return ListTile(
      leading: Image.network(
        c.imagen!,
        fit: BoxFit.fill,
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15.0),
          Text(c.nombre!),
          const SizedBox(height: 10.0),
          Text(c.cuenta.toString()),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    editarContador(false, c, index);
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    size: 50.0,
                    color: Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    editarContador(true, c, index);
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 50.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          snacker(c);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.deepOrange,
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
          const Text('Borrar elemento?'),
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
}
