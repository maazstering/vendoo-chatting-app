import 'package:firebase_core/firebase_core.dart';
import 'package:vendoo/screens/signup.dart';
import 'package:vendoo/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Homepage',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              brightness:
                  themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.purple,
              brightness: Brightness.dark,
            ),
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Ventoo.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                              color: Colors.grey), // Add border color
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(
                          8), // Adjust elevation
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFD9D9D9)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                              color: Colors.grey), // Add border color
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(
                          8), // Adjust elevation
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatRoomJoiningPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      shadowColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(0, 0),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          height: 1.24,
                        ),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF53EAEB),
                            Color(0xFF016BB4),
                            Color(0xFF2D3A93),
                            Color(0xFF8139B8),
                            Color(0xFF783BB3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0712, 0.285, 0.4562, 0.7251, 0.9251],
                        ),
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Chat',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(
                Provider.of<ThemeProvider>(context).isDarkMode
                    ? Icons.nightlight_round
                    : Icons.wb_sunny_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
