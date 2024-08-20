  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:educode/models/historial.dart';
  import 'package:educode/models/usuarios.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  class HistorialController {
    final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

    Future<void> CrearDocumento({
      required User? currentUser,
    }) async {
      try {
        final data = Usuarios(
          nombreUsuario: currentUser!.displayName ?? "",
        );

        final userDocRef = usuarioRef.doc(currentUser.uid);
        await userDocRef.set(data.toJson());
      } catch (e) {
        print("Error al crear el documento: $e");
      }
    }

    Future<void> AgregarAlHistorial({
      required User? currentUser,
      required int score,
      required String now,
      required String topic,
    }) async {
      try {
        final data = Historial(now: now, puntuacion: score, topic: topic);

        final docRef = usuarioRef.doc(currentUser!.uid);

        final historyRef = docRef.collection('historial');
        await historyRef.add(data.toJson());
      } catch (e) {
        print("Error al agregar al historial: $e");
      }
    }

    // Retorna el historial
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

    // Método para retornar la colección completa de usuarios
      Future<String> getNombreUsuario(User? currentUser) async {
    if (currentUser == null) {
      return 'Usuario no autenticado';
    }

    try {
      final docRef = usuarioRef.doc(currentUser.uid);
      final snapshot = await docRef.get();

      if (snapshot.exists) {
        // Extrae el campo 'nombreUsuario' del documento y lo retorna
        final nombreUsuario = snapshot.data()?['usuario'] ?? 'Nombre no disponible';
        return nombreUsuario;
      } else {
        return 'Usuario no encontrado';
      }
    } catch (e) {
      print('Error al obtener el nombre de usuario: $e');
      return 'Error al obtener datos';
    }
  }

    // Nuevo método para actualizar el nombre de usuario
  Future<void> actualizarNombreUsuario({
    required String uid,
    required String nuevoNombreUsuario,
  }) async {
    try {
      final docRef = usuarioRef.doc(uid);
      await docRef.update({'usuario': nuevoNombreUsuario});
      print("Nombre de usuario actualizado correctamente");
    } catch (e) {
      print("Error al actualizar el nombre de usuario: $e");
    }
  }

  }
