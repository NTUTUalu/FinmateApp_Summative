import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile_page.dart';
import 'login_screen.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  final BuildContext context;

  SignUpPage({required this.context});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String username;
  late String phoneNumber;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  Future<void> signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'username': username,
        'phoneNumber': phoneNumber,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'The account already exists for that email.',
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to sign up. Please try again later.',
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to sign up. Please try again later.',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
          'assets/box.png',
          width: 170,
          height: 240,
        ),
      ),
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 230),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        maxLength: 25,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors
                              .blue, // Change the color to your desired one
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        maxLength:
                            15, // Set the maximum length to 50 characters
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors
                              .blue, // Change the color to your desired one
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          username = value;
                        },
                        maxLength: 25,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors
                              .blue, // Change the color to your desired one
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                          prefixIcon: Icon(Icons
                              .person), // add an icon to the left of the input field
                        ),
                      ),
                      TextFormField(
                        onChanged: (value) {
                          phoneNumber = value;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors
                              .blue, // Change the color to your desired one
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        maxLength: 12,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                          ),
                          prefixIcon: Icon(Icons
                              .phone), // add an icon to the left of the input field
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 370,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signUp(); // call the signUp function to create a new user
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homep(),
                                ));
                          },
                          child: Text(
                            'Continue as a guest',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              color: Colors.blue.withOpacity(0.5),
                            ),
                          )),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          ' Already have an account, Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            letterSpacing: 0,
                            color: Colors.blue.withOpacity(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ]));
  }
}
