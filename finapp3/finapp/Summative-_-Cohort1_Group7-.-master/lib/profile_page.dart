import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dummy.dart';
import 'notifications.dart';
import 'package:path/path.dart' as path;
import 'package:quickalert/quickalert.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';
  String _username = '';
  String _phoneNumber = '';
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void showAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      confirmBtnText: 'Yes',
      text: 'Logging Out',
      cancelBtnText: 'No',
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

  Future<String?> uploadImageToFirebase(File imageFile, String fileName) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('profilePictures/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> _fetchUserData() async {
    try {
      // Initialize Firebase if it hasn't been initialized yet
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Get the currently signed-in user's UID
      final uid = FirebaseAuth.instance.currentUser!.uid;

      // Query the Firestore collection for the user's document
      final snapshot = await _firestore.collection('users').doc(uid).get();

      // Get the email, username, and phone number fields from the document
      final data = snapshot.data()!;
      _email = data['email'];
      _username = data['username'];
      _phoneNumber = data['phoneNumber'];
      final photoUrl = data['photoUrl'];

      // Update the UI with the retrieved data
      setState(() {
        _photoUrl = photoUrl;
      });
    } catch (e) {
      // Handle any errors
      print(e.toString());
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // Add this line to make app bar white
          title: Text(
            'Welcome to your Profile Page',
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                showAlert();
              },
            ),
          ],
        ),


        

        body: SingleChildScrollView(
          child: _email == null || _username == null || _phoneNumber == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 30),
                    Center(
                      child: Stack(children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          backgroundImage: _photoUrl == null
                              ? AssetImage("assets/profile3.png")
                                  as ImageProvider<Object>?
                              : NetworkImage(_photoUrl!)
                                  as ImageProvider<Object>?,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.white,
                              ),
                              color: Colors.blue,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                // Open file picker to select an image
                                final pickedFile = await ImagePicker()
                                    .getImage(source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  // Upload the selected image to Firebase Storage
                                  final fileName =
                                      path.basename(pickedFile!.path);

                                  final file = File(pickedFile.path);
                                  final downloadUrl =
                                      await uploadImageToFirebase(
                                          file, fileName);

                                  // Update the photoUrl field in Firestore for the current user
                                  final uid =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  await _firestore
                                      .collection('users')
                                      .doc(uid)
                                      .update({'photoUrl': downloadUrl});

                                  // Update the UI with the new photo
                                  setState(() {
                                    _photoUrl = downloadUrl;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 30),
                    Divider(
                      height: 4,
                      thickness: 2,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    Ink(
                      color: Colors.blue.withOpacity(0.05),
                      child: Card(
                        margin: EdgeInsets.all(16),
                        child: ListTile(
                          title: Text('Email'),
                          subtitle: Text(_email),
                          leading: Icon(Icons.email, size: 35),
                        ),
                      ),
                    ),
                    Divider(
                      height: 4,
                      thickness: 2,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    Ink(
                      color: Colors.blue.withOpacity(0.05),
                      child: Card(
                        margin: EdgeInsets.all(16),
                        child: ListTile(
                          title: Text('Username'),
                          subtitle: Text(_username),
                          leading: Icon(Icons.person, size: 35),
                        ),
                      ),
                    ),
                    Divider(
                      height: 4,
                      thickness: 2,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.grey.withOpacity(0.4),
                    ),
                    Ink(
                      color: Colors.blue.withOpacity(0.05),
                      child: Card(
                        margin: EdgeInsets.all(16),
                        child: ListTile(
                          title: Text('Phone Number'),
                          subtitle: Text(_phoneNumber),
                          leading: Icon(Icons.phone, size: 35),
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(children: [
                        Container(
                          child: Lottie.network(
                            'https://assets7.lottiefiles.com/packages/lf20_fN91t3YtTf.json',
                            height: 220,
                            width: 500,
                          ),
                        ),
                      ]),
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
                Opacity(
                  opacity: 0.5,
                  child: IconButton(
                    icon: Icon(Icons.home, size: 35),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                      // navigate to card-related page
                    },
                  ),
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
                IconButton(
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
              ],
            ),
          ),
        ));
  }
}
