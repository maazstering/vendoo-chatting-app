import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import 'package:vendoo/screens/login/ui/login.dart';
import 'package:vendoo/screens/signup/ui/signup.dart';
import '../../../main.dart';
import 'package:provider/provider.dart';
import '../../../api/apis.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  final HomeBloc homeBloc = HomeBloc();

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>.value(
      value: homeBloc,
      //child :create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if(state is HomeLoginPageNavigateActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          }
          else if(state is HomeSignPageUpNavigateActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
          }
          else if(state is HomeChatPageNavigateActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatRoomJoiningPage()));
          }
          
        },
        builder: (context, state) {
          final homeBloc = BlocProvider.of<HomeBloc>(context);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Positioned(
                  // top: 30,
                  // right: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
                ),
              ],
            ),
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Ventoo.png',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            homeBloc.add(HomepageLoginButtonNavigateEvent());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFD9D9D9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                    color: Colors.grey), // Add border color
                              ),
                            ),
                            elevation:
                                MaterialStateProperty.all<double>(8), // Adjust elevation
                          ),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            homeBloc.add(HomepageSignUpButtonNavigateEvent());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFD9D9D9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: const BorderSide(
                                    color: Colors.grey), // Add border color
                              ),
                            ),
                            elevation:
                                MaterialStateProperty.all<double>(8), // Adjust elevation
                          ),
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[800]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            homeBloc.add(HomepageChatButtonNavigateEvent());
                          },
                          style: ButtonStyle(
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            minimumSize:
                                MaterialStateProperty.all<Size>(const Size(0, 0)),
                            elevation: MaterialStateProperty.all<double>(0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                height: 1.24,
                              ),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
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
                              child: const Text(
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
                
              ],
            ),
          );
        },
      ),
    );
  }
}
