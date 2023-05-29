import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:vendoo/data/repo/auth/base_auth_repo.dart';

class AuthRepo extends BaseAuthRepo{

final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

@override
Future<auth.User?> signUp({
  required String email,
  required String password,
}) async{
  try{
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      final user = credential.user;
      return user;
  } catch (_){}
}

Future<auth.User?> LogInWithEmailAndPassword ({
  required String email,
  required String password,
}) async{
  try{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );
  } catch (_){}
}

@override
Stream<auth.User?> get user => _firebaseAuth.userChanges();

Future<void> signOut() async{
  await _firebaseAuth.signOut();
}


}

