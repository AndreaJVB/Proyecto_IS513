
import 'package:educode/controllers/avatar_controller.dart';
import 'package:educode/interfaces/pages/login_register/widgets/botonesLRI_custom.dart';
import 'package:educode/interfaces/pages/login_register/widgets/screen_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Inicio extends StatelessWidget{
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    //VARIABLES
   final screenP = ScreenProperty(context: context);
    const color2 = Color.fromARGB(255, 127, 78, 188);
    final textStyle = TextStyle(fontFamily: 'Times New Romans', fontSize: 25, color: color2, fontWeight: FontWeight.bold);
    final textStyle2 = TextStyle(fontFamily: 'Times New Romans', fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold);
    final textStyle3 = TextStyle(fontFamily: textStyle2.fontFamily, fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600);
    final textStyle4 = TextStyle(fontFamily: textStyle3.fontFamily, fontSize: 15, fontWeight: FontWeight.w500);
    /**------NAVEGACION------- */
  
    

    return Scaffold(
      body: Container(
        width: screenP.ancho,
        height: screenP.altura,
        decoration: BoxDecoration(
          gradient: screenP.fondoGradiente(),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              runSpacing: 60,
              spacing: 60,
              children: [
                  Column(
                    children: [
                        Text("BIENVENIDO", style: TextStyle(color: textStyle.color, fontSize: 40, fontWeight: textStyle.fontWeight),),
                        Text("EDUCODE", style: TextStyle(color: textStyle2.color, fontSize: textStyle2.fontSize, fontWeight: textStyle2.fontWeight),),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Aprender siempre ha sido una aventura", style: textStyle3,),
                      ),
                      Text("¡COMENZEMOS!", style: textStyle3,)
                    ],
                  ),
                 Column(
                   children: [
                     Image.asset("lib/assets/coding.png", width: screenP.ancho*0.9,),
                     const SizedBox(height: 20,),
                     OutlinedButtomInicio(ancho: screenP.ancho, texto: "Iniciar Sesion", color: Colors.white, size: Size(screenP.ancho*0.7, 50,),
                     textStyle: textStyle4, funcion: ()=>Get.toNamed('/login'),),
                     const SizedBox(height: 10,),
                      const Text("O"),
                      const SizedBox(height: 10,),
                      OutlinedButtomInicio(ancho: screenP.ancho, texto: "Registrarse", color: Colors.white, size: Size(screenP.ancho*0.7, 50,),
                      textStyle: textStyle4, funcion: ()=>Get.toNamed('/registro'),
                      ),
                   ],
                 ),
               ]),
          ),
        ),
      ),
    );
   }
  }