import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../api/apis.dart';
import '../../../models/chat_user.dart';
import 'package:vendoo/screens/home/ui/homepage.dart';

class AccountPage extends StatefulWidget {
  late ChatUser user;
  //final FirebaseAuth auth = FirebaseAuth.instance;
  AccountPage({required this.user});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isEditing = false;
  bool showSaveButton = false;
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    bioController = TextEditingController(text: widget.user.about);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      showSaveButton = !showSaveButton;
    });
  }

  void saveName() {
    // Save the edited name
    String newName = nameController.text;
    // Add your logic to save the name
    // For example, you can call an API to update the user's name

    toggleEditing(); // Exit edit mode after saving
  }

  void saveBio() {
    // Save the edited bio
    String newBio = bioController.text;
    // Add your logic to save the bio
    // For example, you can call an API to update the user's bio

    toggleEditing(); // Exit edit mode after saving
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          isEditing
              ? TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                )
              : ListTile(
                  leading: Icon(Icons.person),
                  title: Text('${widget.user.name}'),
                ),
          isEditing
              ? TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                  ),
                )
              : ListTile(
                  leading: Icon(Icons.info),
                  title: Text('${widget.user.about}'),
                  onTap: toggleEditing,
                ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('${widget.user.email}'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: toggleEditing,
          ),
        ],
      ),
      bottomNavigationBar: showSaveButton
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: theme.primaryColor, // Use app's primary color as button background
              ),
              onPressed: () {
                saveName();
                saveBio();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          : null,
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
