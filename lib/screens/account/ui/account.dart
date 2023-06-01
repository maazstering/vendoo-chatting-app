import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

class AccountPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('John Doe'),
          ),
          const ListTile(
            leading: Icon(Icons.email),
            title: Text('johndoe@example.com'),
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
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    print('Error signing out: $e');
  }
}
