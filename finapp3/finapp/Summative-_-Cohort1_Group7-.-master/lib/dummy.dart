import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'login_screen.dart';

import 'signup_screen.dart';
import 'notifications.dart';
import 'card.dart'; // assuming this is the file containing the BankCardList screen
import 'transactions.dart'; // assuming this is the file containing the BankCardList screen
import 'transactionhistory.dart';
import 'profile_page.dart';
import 'package:quickalert/quickalert.dart'; // assuming this is the file containing the BankCardList screen

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showAlert() {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        text: 'Logging Out',
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LoginPage(),
            ),
          ); // Na
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue, // Add this line to make app bar white
            leading: Image(
                image: AssetImage("assets/cardi.png"), height: 40, width: 40),
            title: Text(
              'FinMate',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    showAlert();
                  }),
            ]),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      'Fin App',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Version 12.3',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.blue),
                  ),
                  onTap: () {
                    // Handle item 1 press
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 9),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.blue.withOpacity(
                        0.05), // set the background color of the container
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
                              child: Column(
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
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BankCardList(),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    image: AssetImage("assets/cardicon.png"),
                                    height: 30,
                                    width: 30,
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
                ),
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionsHistoryPage()),
                        );
                        // navigate to contacts page
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionsHistoryPage()),
                        );
                      },
                      // navigate to transfers page

                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransactionsPage()),
                              );
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
              ),
              SizedBox(height: 16),
              Divider(),
              Container(
                color: Colors.blue[100],
                child: SizedBox(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 100, // Set the desired height of the card
                          child: Card(
                            // Set the desired margin for the card
                            child: ListTile(
                              leading: Icon(Icons.payment, size: 30),
                              title: Text(
                                'You received payment',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              subtitle: Text(
                                '\$50\nAmmy Silver',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                  16), // Set the desired padding for the contents
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100, // Set the desired height of the card
                          child: Card(
                            // Set the desired margin for the card
                            child: ListTile(
                              leading: Icon(Icons.payment, size: 30),
                              title: Text(
                                'You received payment',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              subtitle: Text(
                                '\$100\nAmmy Silver',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                  16), // Set the desired padding for the contents
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100, // Set the desired height of the card
                          child: Card(
                            // Set the desired margin for the card
                            child: ListTile(
                              leading: Icon(Icons.payment, size: 30),
                              title: Text(
                                'You received payment',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              subtitle: Text(
                                '\$900\nAmmy Silver',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                  16), // Set the desired padding for the contents
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 100, // Set the desired height of the card
                          child: Card(
                            // Set the desired margin for the card
                            child: ListTile(
                              leading: Icon(Icons.payment, size: 30),
                              title: Text(
                                'You received payment',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              subtitle: Text(
                                '\$900\nAmmy Silver',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal:
                                  16), // Set the desired padding for the contents
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          child: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, size: 35),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    // navigate to card-related page
                  },
                ),
                Opacity(
                  opacity: 0.5,
                  child: IconButton(
                    icon: Icon(Icons.notifications, size: 35),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => notificationsPage()),
                      );
                    },
                  ),
                ),
                Opacity(
                  opacity: 0.5,
                  child: IconButton(
                      icon: Icon(Icons.person, size: 35),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                        // navigate to profile page
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
