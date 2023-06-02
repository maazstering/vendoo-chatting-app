import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../api/apis.dart';
import '../../../models/chat_user.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

class AccountPage extends StatelessWidget {
  late ChatUser user;
  //final FirebaseAuth auth = FirebaseAuth.instance;
  AccountPage({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Manage Account'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/ventooV.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
            child: Icon(Icons.account_circle, size: 150),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('${user.name}'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('${user.email}'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              // Handle edit profile action
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              signOut();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  HomePage(key: const ValueKey('myHomePage'))));
            },
          ),
        ],
      ),
    );
  }
}

void signOut() async {
  try {
    await APIs.auth.signOut();
  } catch (e) {
    print('Error signing out: $e');
  }
}
