class Contador {
  String? nombre;
  int? cuenta;
  String? imagen;

  Contador(String name, [int? count, String? image]) {
    count == null ? cuenta = 0 : cuenta = count;
    image == null
        ? imagen = 'https://cdn-icons-png.flaticon.com/512/16/16642.png'
        : imagen = image;

    nombre = name;
  }

  String getNombre() => nombre!;
}
