import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/models/usuarios.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistorialController {
  final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

  Future<void> CrearDocumento ({
    required User? currentUser,
  }) async {
    try{
      final data = Usuarios(
        nombreUsuario: currentUser!.displayName ?? "");

        final userDocRef = usuarioRef.doc(currentUser.uid);
        await userDocRef.set(data.toJson());

        // Crear la subcolección 'historial'
      // final historialRef = userDocRef.collection('historial');

      //  await historialRef.doc(currentUser.uid);
      //  historialRef.add(
      //   {
      //   'created_at': FieldValue.serverTimestamp(),
      //   'action': 'User created',
      // }
      //  );

    }catch (e){

    }
  }
}