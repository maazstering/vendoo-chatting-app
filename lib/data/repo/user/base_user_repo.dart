import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseUserRepo{
  Stream<User> getUser(String userID);
  Future<void> createUser (User user);
  Future<void> updateUser (User user);
}