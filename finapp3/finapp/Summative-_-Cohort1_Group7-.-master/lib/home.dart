import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:finmate/login_screen.dart';
import 'profile_page.dart';
import 'signup_screen.dart';
import 'package:quickalert/quickalert.dart';

class Homep extends StatefulWidget {
  const Homep({Key? key}) : super(key: key);

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;

  void showAlert() {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: "You are required to Sign In first",
        title: "Alert !");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // Add this line to make app bar white
          leading: Image(
              image: AssetImage("assets/background.png"),
              height: 40,
              width: 40),
          title: Text(
            'FinMate',
            style: TextStyle(
              fontSize: 23,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),

          actions: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: Colors.white, // button background color
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.blue, // text color
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(width: 300),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage("assets/card2.png"),
                          height: 180,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: InkWell(
                            onTap: () {
                              showAlert();
                            },
                            child: Image(
                              image: AssetImage("assets/cardicon.png"),
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                7), // add some space between the image and the label
                        Text(
                          "Add\nCards",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    showAlert();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.contacts, size: 30),
                      SizedBox(height: 8),
                      Text(
                        'Your Transactions',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You are required to sign in.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  // navigate to transfers page

                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showAlert();
                        },
                        child: Column(
                          children: [
                            Icon(Icons.attach_money, size: 30),
                            SizedBox(height: 8),
                            Text(
                              'Transfer Money',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            Container(
              color: Colors.grey.withOpacity(0.2),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Why FinMate',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
                      child: Divider(
                        height: 4,
                        thickness: 2,
                        indent: 20,
                        endIndent: 0,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          SizedBox(width: 90),
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/service.png"),
                                height: 180,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Excellent Service",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/phone.png"),
                                height: 180,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Global Peer-To-Peer \n Transactions",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                          SizedBox(width: 90),
                          Column(
                            children: [
                              Image(
                                image: AssetImage("assets/security.png"),
                                height: 180,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Guaranteed \nSecurity",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey,
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {},
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpPage(context: context)),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(Icons.arrow_forward,
                                  color: Colors.blue, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
