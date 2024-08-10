import 'package:flutter/material.dart';

class TextPassword extends StatelessWidget {
  const TextPassword({
    super.key,
    required this.password,
    required this.label,
  });

  final TextEditingController password;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: password,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
      obscureText: true,
    );
  }
}
