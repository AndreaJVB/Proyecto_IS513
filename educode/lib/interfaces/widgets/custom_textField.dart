import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    super.key,
    this.hintText,
    this.prefixIcono,
    this.fillColor,
    this.obscureText = false,
    this.enable = true
  });
    final String? hintText;
    final IconData? prefixIcono;
    final Color? fillColor;
    final bool obscureText;
    final bool enable;
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enable,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcono),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: fillColor,
      ),
      obscureText: obscureText,
    );
  }
}