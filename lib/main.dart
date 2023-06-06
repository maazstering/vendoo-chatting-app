//import 'package:firebase_auth/firebase_auth.dart';
// import 'screens/signup/ui/signup.dart';
import 'screens/home/ui/homepage.dart';
//import 'screens/chat/ui/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'screens/login/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCxZ-1e4LBtxYpi82i86yTRjl9NBgu1I-k",
          appId: "1:119840048542:android:424448d97c606e3cb8028f",
          messagingSenderId: "119840048542",
          projectId: "vendoo-chat",
          storageBucket: "vendoo-chat.appspot.com"
          ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
            home: HomePage(
                key:
                    ValueKey('myHomePage')), // to take you to the main homepage
            debugShowCheckedModeBanner: false,
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
