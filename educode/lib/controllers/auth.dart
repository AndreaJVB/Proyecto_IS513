import 'package:educode/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  final getUser = Get.put<UserController>(UserController());

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
        try {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, 
            password: password
          );
          if(_firebaseAuth.currentUser != null){
            getUser.user.value = currentUser;
            Get.offAllNamed('/home');
          }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String nombre,
    required String lastName
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );
     await _firebaseAuth.currentUser!.updateProfile(
      displayName:"${nombre} ${lastName}", photoURL: "" );
      
      // Enviar correo de verificación después de crear el usuario
      await sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
      print("Correo de verificación enviado.");
    } on FirebaseAuthException catch (e) {
      print("Error: ${e.message}");
    }
  }
}
