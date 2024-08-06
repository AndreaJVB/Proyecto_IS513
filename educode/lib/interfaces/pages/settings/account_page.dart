import 'package:educode/interfaces/widgets/circle_avatar.dart';
import 'package:educode/controllers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? user = Auth().currentUser;

  Future <void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFFFF5F6D),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      CircleAvatarCustom(),
                    SizedBox(height: 10),
                    Text(
                      'Nombre de Usuario',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'usuario@example.com',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            ListTitleCustom(text:"Mi cuenta", icono: Icons.account_circle,),
            Divider(),
            ListTitleCustom(text:"Configuración", icono:  Icons.settings,),
            Divider(),
            ListTitleCustom(text:"Notificaciones", icono: Icons.notifications,),
            Divider(),
            ListTitleCustom(text: "Cambiar de modo", icono: Icons.model_training_rounded,),
            Divider(),
            ListTitleCustom(text: "Cerrar Sesion", icono: Icons.logout,)
          ],
        ),
      ),
    );
  }
}

class ListTitleCustom extends StatelessWidget {
  const ListTitleCustom({
    super.key,
    required this.text,
    required this.icono
  });
  final String text;
  final IconData icono;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icono, color: Color(0xFFFF5F6D)),
      title: Text(text),
      onTap: () {},
    );
  }
}