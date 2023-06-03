import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:vendoo/models/chat_user.dart';

import '../models/messages.dart';

final User? cuser = FirebaseAuth.instance.currentUser;

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String? cuser; // replace with actual user UID (Firebase User UID)

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: cuser.toString(),
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());

    final receiverRef =
        firestore.collection('users').doc(chatUser.id).collection('messages');
    await receiverRef.doc(time).set(message.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('users')
        .doc(cuser)
        .collection('messages')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  //get instance of the current user
  static User get user => auth.currentUser!;

  //creating a user instance for myself
  static late ChatUser me;

// checking to see if a user already exists
  static Future<bool> userExists() async {
    if (user != null) {
      final userSnapshot =
          await firestore.collection('users').doc(user.uid).get();
      return userSnapshot.exists;
    }
    return false;
  }

  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    //print("user object created");
    final chatUser = ChatUser(
        id: user.uid,
        name: 'new user', //user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey I am using vendoo",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    //adding the user to the firestore collection
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Future<void> sendFirstMessage(
      ChatUser chatUser, String msg, Type type) async {
        //print('inside first message');
    await firestore
        .collection('users')
        .doc(chatUser.id)
        .collection('my_users')
        .doc(user.uid)
        .set({}).then((value) => sendMessage(chatUser, msg, type));
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

// updating the user info in the firestore database
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
  //     ChatUser user) {
  //   return firestore.collection('Messages').snapshots();
  // }

  static getConversationID(String id) {
    if (cuser!.compareTo(id) > 0) {
      return cuser! + '-' + id;
    } else {
      return id + '-' + cuser!;
    }
  }
}
