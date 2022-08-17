import 'package:flutter/material.dart';
import 'package:untitled/model/contador.dart';
import 'package:untitled/model/listado.dart';

class NuevoContador extends StatefulWidget {
  const NuevoContador({Key? key}) : super(key: key);

  @override
  State<NuevoContador> createState() => _NuevoContadorState();
}

class _NuevoContadorState extends State<NuevoContador> {
  String nombre = '';
  String contador_inicial = '0';
  bool fallido = false;
  bool nombreFallido = false;
  String imagen = 'https://cdn-icons-png.flaticon.com/512/16/16642.png';

  String imagenSeleciconada = '';

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? vertivalView()
        : horizontalView();
  }

  Widget vertivalView() => SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text(
                  'Crear nuevo contador',
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                ),
                const SizedBox(height: 40.0),
                Image.network(
                  imagen,
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.link_rounded,
                      color: Colors.purple,
                    ),
                    labelText: 'URL (.png | .jpg | .jpeg)',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: imagenSeleciconada == 'error'
                            ? Colors.red
                            : Colors.purple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: imagenSeleciconada == 'error'
                              ? Colors.red
                              : Colors.purple),
                    ),
                  ),
                  onChanged: (valor) =>
                      setState(() => imagenSeleciconada = valor),
                ),
                OutlinedButton(
                  onPressed: () {
                    setImagen();
                  },
                  child: const Text('cambiar imagen'),
                ),
                const SizedBox(height: 40.0),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.abc_rounded,
                      color: Colors.purple,
                    ),
                    labelText: 'Nombre (max 20)',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color:
                            nombreFallido == true ? Colors.red : Colors.purple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: nombreFallido == true
                              ? Colors.red
                              : Colors.purple),
                    ),
                  ),
                  onChanged: (valor) => setState(() {
                    if (valor.length <= 20) {
                      setState(() {
                        nombre = valor;
                        nombreFallido = false;
                      });
                    } else {
                      setState(() {
                        nombre = valor;
                        nombreFallido = true;
                      });
                    }
                  }),
                ),
                const SizedBox(height: 40.0),
                TextField(
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.numbers_rounded,
                      color: Colors.purple,
                    ),
                    labelText: 'Contador inicial',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                        color: fallido == true ? Colors.red : Colors.purple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: fallido == true ? Colors.red : Colors.purple),
                    ),
                  ),
                  onChanged: (valor) => setState(
                    () {
                      setState(
                        () {
                          if (valor == "") {
                            contador_inicial = '0';
                          } else {
                            contador_inicial = valor;
                          }
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40.0),
                OutlinedButton(
                  onPressed: () {
                    checkFields();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      );

  Widget horizontalView() => Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        imagen,
                        height: 130,
                        width: 130,
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.link_rounded,
                            color: Colors.purple,
                          ),
                          labelText: 'URL (.png | .jpg | .jpeg)',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: imagenSeleciconada == 'error'
                                  ? Colors.red
                                  : Colors.purple,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: imagenSeleciconada == 'error'
                                    ? Colors.red
                                    : Colors.purple),
                          ),
                        ),
                        onChanged: (valor) =>
                            setState(() => imagenSeleciconada = valor),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setImagen();
                        },
                        child: const Text('cambiar imagen'),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.abc_rounded,
                            color: Colors.purple,
                          ),
                          labelText: 'Nombre (max 20)',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color: nombreFallido == true
                                  ? Colors.red
                                  : Colors.purple,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: nombreFallido == true
                                    ? Colors.red
                                    : Colors.purple),
                          ),
                        ),
                        onChanged: (valor) => setState(() {
                          if (valor.length <= 20) {
                            setState(() {
                              nombreFallido = false;
                              nombre = valor;
                            });
                          } else {
                            setState(() {
                              nombre = valor;
                              nombreFallido = true;
                            });
                          }
                        }),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.numbers_rounded,
                            color: Colors.purple,
                          ),
                          labelText: 'Contador inicial',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(
                              color:
                                  fallido == true ? Colors.red : Colors.purple,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: fallido == true
                                    ? Colors.red
                                    : Colors.purple),
                          ),
                        ),
                        onChanged: (valor) => setState(
                          () {
                            setState(
                              () {
                                if (valor == "") {
                                  contador_inicial = '0';
                                } else {
                                  contador_inicial = valor;
                                }
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      OutlinedButton(
                        onPressed: () {
                          checkFields();
                        },
                        child: const Text('Guardar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  void checkFields() {
    if (nombre != "" && nombreFallido != true) {
      nombreFallido = false;
      try {
        Contador c = Contador(
            nombre: nombre,
            contador: int.parse(contador_inicial),
            imagen: imagen);

        setState(
          () {
            succedSnacker();
            Listado().contadores.add(c);
            fallido = false;
          },
        );
        debugPrint('${c.nombre},${c.contador},${c.imagen}');
      } on FormatException {
        setState(
          () {
            failSnacker();
            fallido = true;
            contador_inicial = '0';
          },
        );
      }
    } else {
      setState(() {
        nombreFallido = true;
      });
      failSnacker();
    }
  }

  void failSnacker() {
    var mensaje = SnackBar(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 68,
            ),
            Text(
              'no ha introducido un contador valido',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 300),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(mensaje);
  }

  void succedSnacker() {
    var mensaje = SnackBar(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 68,
            ),
            Text(
              'Contador guardado',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 300),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(mensaje);
  }

  setImagen() {
    if (imagenSeleciconada.endsWith('.png') ||
        imagenSeleciconada.endsWith('.jpg') ||
        imagenSeleciconada.endsWith('.jpeg')) {
      setState(() {
        imagen = imagenSeleciconada;
      });
    } else {
      setState(() {
        imagenSeleciconada = 'error';
      });
      failSnacker();
    }
  }
}
