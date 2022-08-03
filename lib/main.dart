import 'package:flutter/material.dart';
import 'package:untitled/nuevo_contador.dart';
import 'package:untitled/ver_contadores.dart';

void main(List<String> args) {
  runApp(const MyApp());
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
  var paginas = const [VerContadores(), NuevoContador()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contadores'),
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
}
