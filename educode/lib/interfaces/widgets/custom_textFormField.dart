import 'package:flutter/material.dart';

class TextFormCustom extends StatelessWidget {
  const TextFormCustom({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        hintStyle: const TextStyle(fontWeight: FontWeight.w600),
        counterStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        fillColor: const Color.fromARGB(200, 255, 255, 255),
        filled: true,
        hintText: hintText ?? 'Ingrese su $label',
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
      ),
    );
  }
}