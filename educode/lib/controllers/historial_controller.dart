import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educode/models/historial.dart';
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

    }catch (e){

    }
  }

  Future<void> AgregarAlHistorial({
    required User? currentUser,
    required int score,
    required String now,
    required String topic,
    }
  ) async {
    try{

      final data = Historial(now: now,
       puntuacion: score, topic: topic);

      final docRef = usuarioRef.doc(currentUser!.uid);

      final historyRef = docRef.collection('historial');
      await historyRef.add(data.toJson());

    }catch(e){

    }
  }
  //Retorna el historial
   Future<List<Map<String, dynamic>>> getHistorial(User? currentUser) async {
    if (currentUser == null) return [];

    final docRef = usuarioRef.doc(currentUser.uid);
    final historyRef = docRef.collection('historial');
    final snapshot = await historyRef.get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> agregarAlHistorial({
    required User? currentUser,
    required int score,
    required String now,
    required String topic,
  }) async {
    if (currentUser == null) return;

    final data = {
      'puntuacion': score,
      'now': now,
      'topic': topic,
    };

    final docRef = usuarioRef.doc(currentUser.uid);
    final historyRef = docRef.collection('historial');
    await historyRef.add(data);
  }

}