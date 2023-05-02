import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'card.dart';
import 'dummy.dart';
import 'home.dart';
import 'profile_page.dart';
import 'signup_screen.dart';
import 'transactionhistory.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // navigate to home page or user profile page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User not found');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/box.png',
              width: 170,
              height: 240,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 200),
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(height: 50),
                  TextField(
                    onChanged: (value) {
                      email = value;
                    },
             
                    maxLength: 25, // Set the maximum length to 50 characters
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      color:
                          Colors.blue, // Change the color to your desired one
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      prefixIcon: Icon(Icons.email),
                      counterText: "", // Remove the character counter text
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    maxLength: 15,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 1,
                      color:
                          Colors.blue, // Change the color to your desired one
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter you password',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(height: 32),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: signIn,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                        color: Colors.grey.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homep()),
                        );
                      },
                      child: Text(
                        'Continue as a GUEST',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0,
                          color: Colors.blue.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpPage(context: context)),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          letterSpacing: 0,
                          color: Colors.blue.withOpacity(1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
