import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
