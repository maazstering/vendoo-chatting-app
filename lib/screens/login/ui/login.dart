import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import 'package:vendoo/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../signup/ui/signup.dart';
import '../../../api/apis.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = LoginBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    try {
      await APIs.auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in'),
          duration: Duration(seconds: 2),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('Error code: ${e.code}');
      print('Error message: ${e.message}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not found. Invalid email or password.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>.value(
      value: loginBloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        // listenWhen: (previous, current) => current is LoginActionState,
        // buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is SignUpPageNavigateState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupPage()));
          } else if (state is LoginSubmittedInfoState) {
            login(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: StreamBuilder<User?>(
                stream: APIs.auth.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  } else if (snapshot.hasData) {
                    return ChatRoomJoiningPage();
                  } else {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: true,
                        title: const Text('Login'),
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
                      body: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/images/Ventoo.png',
                                width: 150,
                                height: 150,
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                ),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSubmitButtonPressedEvent());
                                },
                                child: const Text('Submit'),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  loginBloc
                                      .add(LoginPageSignUpPageNavigateEvent());
                                },
                                child: const Text(
                                  "Don't have an account? Sign Up",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
