import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
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
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
            child: Icon(Icons.account_circle, size: 150),
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('John Doe'),
          ),
          ListTile(
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
              // Handle sign out action
            },
          ),
        ],
      ),
    );
  }
}
