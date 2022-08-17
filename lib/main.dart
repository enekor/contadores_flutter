import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/model/listado.dart';
import 'package:untitled/nuevo_contador.dart';
import 'package:untitled/ver_contadores.dart';

import 'model/contador.dart';
import 'package:http/http.dart' as http;

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
      home: RootPage(),
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
    const NuevoContador()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Contadores actuales ${Listado().contadores.length.toString()}'),
        actions: [
          IconButton(
              onPressed: loadItems, icon: const Icon(Icons.download_rounded))
        ],
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
          )
        ],
        onDestinationSelected: (int selected) =>
            setState(() => pagina = selected),
        selectedIndex: pagina,
      ),
      body: pagina == 0 ? paginas[0] : paginas[1],
    );
  }

  loadItems() async {
    var url = Uri.parse('http://localhost:7777/contadores/all');
    var ans = await http.get(url);

    if (ans.statusCode == 200 || ans.statusCode == 300) {
      debugPrint('tiene contendo');
      ContadoresBD contans = ContadoresBD.fromJson(jsonDecode(ans.body));

      setState(() {
        Listado().contadores = contans.content!;
      });

      debugPrint(Listado().contadores.length.toString());
    } else {
      debugPrint('no tiene contenido');

      setState(() {
        Listado().contadores = [];
      });
    }
  }
}
