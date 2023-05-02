import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e; // re-throw original exception
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e; // re-throw original exception
    } catch (e) {
      throw Exception('Failed to sign in: ${e.toString()}');
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  User? get currentUser {
    return _auth.currentUser;
  }
}
