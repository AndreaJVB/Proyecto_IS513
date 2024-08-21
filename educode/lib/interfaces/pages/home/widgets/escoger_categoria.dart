import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EscogerCategoria extends StatefulWidget {
  const EscogerCategoria({super.key, required this.cantidad});

  final int cantidad;

  @override
  _EscogerCategoriaState createState() => _EscogerCategoriaState();
}

class _EscogerCategoriaState extends State<EscogerCategoria> {
  List<String> categorias = [
    'Base de Datos',
    'Programación',
    'Programación Orientada a Objetos',
    'Algoritmos',
    'Lenguaje de Programación'
  ];

  List<String> seleccionadas = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Selecciona categorías'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: categorias.map((categoria) {
            return CheckboxListTile(
              title: Text(categoria),
              value: seleccionadas.contains(categoria),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    seleccionadas.add(categoria);
                  } else {
                    seleccionadas.remove(categoria);
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (seleccionadas.length >= widget.cantidad) {
              // Do something with the selected categories
              Get.back(result: seleccionadas);
            } else {
              // Show a message to select at least two categories
              Get.snackbar(
                'Error',
                'Selecciona al menos dos categorías',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.redAccent,
                colorText: Colors.white,
              );
            }
          },
          child: Text('Confirmar'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancelar'),
        ),
      ],
    );
  }
}
