import 'package:flutter/material.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

var contadoresList = Listado.getInstace().contadores;

class VerContadores extends StatefulWidget {
  const VerContadores({Key? key}) : super(key: key);

  @override
  _VerContadoresState createState() => _VerContadoresState();
}

class _VerContadoresState extends State<VerContadores> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(contadores()));
  }

  String contadores() {
    String ans = '';
    for (Contador c in contadoresList) {
      ans += '${c.nombre!}\n';
    }
    return ans;
  }
}
