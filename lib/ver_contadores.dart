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
        itemBuilder: (BuildContext context, int index) => ListTile(
          leading: Image.network(Listado().contadores[index].imagen!),
          title: Text(Listado().contadores[index].nombre!),
          trailing: Text(Listado().contadores[index].cuenta.toString()),
        ),
      ),
    );
  }
}
