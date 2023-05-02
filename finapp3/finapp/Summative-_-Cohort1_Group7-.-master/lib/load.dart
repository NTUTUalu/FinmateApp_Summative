import 'dart:async';
import 'dart:ui'; // add this line
import 'package:finmate/signup_screen.dart';
import 'package:flutter/material.dart';
import 'dummy.dart';
import 'login_screen.dart';

import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progressValue = 0;

  @override
  void initState() {
    super.initState();
    // simulate a task with progress
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _progressValue += 0.1;
        if (_progressValue >= 1) {
          timer.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets6.lottiefiles.com/packages/lf20_q8mar8hq.json',
            ),
            SizedBox(height: 4),
            Text(
              'FinMate',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Transact Directly, Securely, Seamlessly',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 50),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: _progressValue,
                ),
                Text(
                  '${(_progressValue * 100).toInt()}%',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
