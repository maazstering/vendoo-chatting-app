import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/models/chat_user.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get instance of the current user
  static User get user => auth.currentUser!;

  //creating a user instance for myself
  static late ChatUser me;

// checking to see if a user already exists
  static Future<bool> userExists() async {
    if (user != null) {
      final userSnapshot =
          await firestore.collection('Users').doc(user.uid).get();
      return userSnapshot.exists;
    }
    return false;
  }

  static Future<void> getSelfInfo() async {
          await firestore.collection('Users').doc(user.uid).get().then((user) async {
            if (user.exists){
              me = ChatUser.fromJson(user.data()!);
            }else{
              await createUser().then((value) => getSelfInfo());
            }
          });
    }


  //creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    print("user object created");
    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey I am using vendoo",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    //adding the user to the firestore collection
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return firestore.collection('Users').where('id', isNotEqualTo: user.uid).snapshots();
  }
}
