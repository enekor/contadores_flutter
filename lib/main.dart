import 'package:flutter/material.dart';
import 'package:untitled/adquirir_desde_api.dart';
import 'package:untitled/model/listado.dart';
import 'package:untitled/nuevo_contador.dart';
import 'package:untitled/ver_contadores.dart';

import 'model/contador.dart';

List<Contador> contadores = [];
void main(List<String> args) {
  runApp(const MyApp());
}

@override
void initState() {
  contadores = Listado().contadores;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pagina = 0;
  var paginas = [
    const VerContadores().VerContadoresConstructor(contadores),
    const NuevoContador(),
    const AdquirirDesdeApi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Contadores actuales ${Listado().contadores.length.toString()}'),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, color: Colors.blueGrey),
            label: 'Contadores',
          ),
          NavigationDestination(
            icon: Icon(Icons.add, color: Colors.blueGrey),
            label: 'Nuevo contador',
          ),
          NavigationDestination(
            icon: Icon(Icons.download_rounded, color: Colors.blueGrey),
            label: 'Descargar',
          ),
        ],
        onDestinationSelected: (int selected) =>
            setState(() => pagina = selected),
        selectedIndex: pagina,
      ),
      body: paginas[pagina],
    );
  }
}
