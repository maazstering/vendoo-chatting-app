import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendoo/models/user_model.dart';
import '../user/base_user_repo.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:vendoo/data/repo/user/base_user_repo.dart';

class userRepo extends BaseUserRepo{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  @override
  Future<void> createUser(User user) async{
    await _firebaseFirestore
    .collection('users')
    .doc(user.id)
    .set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userID){
    return _firebaseFirestore.collection('users')
    .doc(userID)
    .snapshots()
    .map((snap) => User.fromSnapShot(snap));
  }

  @override
  Future<void> updateUser(User user) async{
    return _firebaseFirestore
    .collection('users')
    .doc(user.id)
    .update(user.toDocument())
    .then((value) => print(' user document updated'));
  }
}