import 'package:firebase_auth/firebase_auth.dart';
import 'screens/signup/ui/signup.dart';
import 'screens/home/ui/homepage.dart';
import 'screens/chat/ui/chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
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


