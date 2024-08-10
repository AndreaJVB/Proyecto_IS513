import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldAccount extends StatelessWidget {
  const TextFieldAccount({
    super.key,
    required this.nombre,
    required this.isEdit,
    required this.label,
  });

  final TextEditingController nombre;
  final RxBool isEdit;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: 
          TextField(
      controller: nombre,
      enabled: isEdit.value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white24,
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.person, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      style: TextStyle(color: Colors.white),
    )
          ,
        ),
        
        SizedBox(width: 8), // Added spacing between fields
        IconButton(
          onPressed: () {
            isEdit.value = !isEdit.value;
          },
          icon: Icon(
            isEdit.value ? Icons.check : Icons.edit,
            color: Colors.white,
          ),
        ),
      ],
    ));
  }
}
