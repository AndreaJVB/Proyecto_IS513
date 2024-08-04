import 'package:flutter/material.dart';

class ScreenProperty{
  ScreenProperty({required this.context,});
  BuildContext context;
  double? _altura;
  double? _ancho;

  get altura{
    _altura = MediaQuery.of(context).size.height;
    return _altura;
  }
  get ancho{
    _ancho = MediaQuery.of(context).size.width;
    return _ancho;
  }

   LinearGradient fondoGradiente() {
    return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
          Colors.orange[400]!,
          Colors.orange[200]!,
          Colors.purple[200]!,
          Colors.purple[400]!
        ]);
  }
}