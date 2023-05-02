import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';
import 'profile_page.dart';

import 'signup_screen.dart';
import 'dummy.dart';
import 'load.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => LoadingScreen(),
        '/signup': (context) => SignUpPage(context: context),
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomePage(),

        
      },
      
    );
  }
}
