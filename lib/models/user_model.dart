import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? id;
  final String username;
  final String email;
  final String password;

  const User({
    this.id,
    this.username = '',
    this.email = '',
    this.password = '',

  });

  User copyWith({
  final String? id,
  final String? username,
  final String? email,
  final String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  factory User.fromSnapShot(DocumentSnapshot snap){
    return User(
      id: snap.id,
      username: snap['username'],
      email: snap['email'],
      password: snap['password'],
    );
  }

  Map<String, Object> toDocument(){
    return{
      'username' : username,
      'email' : email,
      'password' : password,
    };
  }

  @override
  List<Object?> get props =>
  [id,username,email,password];

}

