import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/adquirir_desde_api.dart';
import 'package:untitled/model/listado.dart';
import 'package:untitled/model/temas.dart';
import 'package:untitled/nuevo_contador.dart';
import 'package:untitled/ver_contadores.dart';
import 'package:get/get.dart';

import 'model/contador.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Temas().getPrimary()),
        home: const RootPage(),
      ),
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
    const VerContadores().VerContadoresConstructor(Listado().contadores),
    const NuevoContador(),
    const AdquirirDesdeApi(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Temas().getBackground(),
        appBar: AppBar(
          title: Text(
              'Contadores actuales ${Listado().contadores.length.toString()}'),
          actions: [
            IconButton(
              onPressed: changeTheme,
              icon: Icon(
                Icons.brush_rounded,
                color: Temas().getSecondary(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: Temas().getBackground(),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          elevation: 200,
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
      ),
    );
  }

  changeTheme() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      Temas().actual.value = prefs.getInt('temaActual')!;
    } catch (e) {
      prefs.setInt('temaActual', 1);
      Temas().actual.value = 1;
    }

    Widget chip(bool isSelected, String texto, int valor) {
      bool seleccionado = isSelected;
      return ChoiceChip(
        label: Text(
          texto,
          style: TextStyle(
              color: seleccionado == true ? Colors.white : Colors.black),
        ),
        selected: seleccionado,
        selectedColor: Temas().getPrimary(),
        onSelected: (value) {
          if (value) {
            setState(() {
              Temas().actual.value = valor;
              seleccionado = value;
              prefs.setInt('temaActual', valor);
            });
          }
        },
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => Container(
            color: Temas().getBackground(),
            child: SizedBox(
              height: 400,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: chip(Temas().actual.value == 1, 'Claro', 1),
                          ),
                          Expanded(
                            flex: 3,
                            child: chip(Temas().actual.value == 2, 'Oscuro', 2),
                          ),
                          Expanded(
                            flex: 3,
                            child: chip(Temas().actual.value == 3, 'Custom', 3),
                          ),
                        ],
                      ),
                      Container(
                        child: Temas().actual.value == 3
                            ? const SizedBox(height: 3)
                            : colorChooser(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget colorChooser() => Container(color: Colors.orange);
}
