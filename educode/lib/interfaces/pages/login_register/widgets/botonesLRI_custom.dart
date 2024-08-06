import 'package:flutter/material.dart';

class OutlinedButtomInicio extends StatelessWidget {
  const OutlinedButtomInicio({
    super.key,
    required this.ancho,
    required this.texto,
    required this.funcion,
    this.color,
    this.size, 
    this.textStyle,
    this.elevation
  });
  final String texto;
  final  ancho;
  final Color? color;
  final Size? size;
  final TextStyle? textStyle;
  final void Function() funcion;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: funcion, child: Text(texto, style: textStyle,), 
    style: ButtonStyle(
     fixedSize: WidgetStatePropertyAll(size),
     backgroundColor: WidgetStatePropertyAll(color),
     elevation: WidgetStatePropertyAll(elevation),
     
     ),
     );
  }
}