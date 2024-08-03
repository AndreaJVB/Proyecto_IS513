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
}