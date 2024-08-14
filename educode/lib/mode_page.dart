
import 'package:educode/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModePage extends StatelessWidget {
  ModePage({super.key});
  final  getUser = Get.put<UserController>(UserController());
  

  @override
  Widget build(BuildContext context) {
    TextStyle texto = TextStyle(fontWeight: FontWeight.bold, fontFamily: "Times New Romas");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
         color: Color.fromARGB(225, 63, 80, 187)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ELIJA UN MODO DE JUEGO", style: TextStyle(fontSize: 25, fontWeight: texto.fontWeight, fontFamily: texto.fontFamily),),
              Text("(Podra cambiar la opcion mas adelante)"),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonCustom(ruta: '/solitario',icono: Icons.person, texto: "Solitario",),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ButtonCustom(
                        ruta: "/multijugador",
                        icono: Icons.group,
                        texto: "Multijugador",
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    super.key,
    required this.ruta,
    required this.icono,
    required this.texto,
  });

  final String ruta;
  final IconData icono;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Ajusta el ancho del botón al contenedor padre
      height: 100, // Altura fija
      child: OutlinedButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Esquinas redondeadas
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(color: const Color.fromARGB(255, 4, 15, 34), width: 2), // Borde azul
          ),
          backgroundColor: WidgetStateProperty.all(const Color.fromARGB(96, 255, 255, 255)),
          overlayColor: WidgetStateProperty.all(
            Colors.blue.withOpacity(0.1), // Efecto de presión
          ),
        ),
        onPressed: () => Get.toNamed(ruta),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icono, size: 30, color: const Color.fromARGB(255, 6, 34, 82)),
              SizedBox(width: 5), // Espacio entre el icono y el texto
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    texto,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
