import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/models/chat_user.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get instance of the current user
  static get user => auth.currentUser!;


// checking to see if a user already exists
  static Future<bool> userExists() async {
    if (user != null) {
      final userSnapshot =
          await firestore.collection('Users').doc(user.uid).get();
      return userSnapshot.exists;
    }
    return false;
  }

  //creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email,
        about: "Hey I am using vendoo",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

        //adding the user to the firestore collection
        return await firestore.collection('Users').doc(user.uid).set(chatUser.toJson());
  }
}
