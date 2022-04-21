import 'package:client/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Duration get delay => const Duration(milliseconds: 1500);

  UserModel? _fetchUserData(User? user) => user != null ? UserModel(uid: user.uid, email: user.email) : null;
  UserModel? get getCurrentUser => _fetchUserData(_firebaseAuth.currentUser);
  Stream<UserModel?> get authStateChanges => _firebaseAuth.authStateChanges().map(_fetchUserData);

  Future<String?> signIn({required String email, required String password}) async {
    debugPrint('Name: $email, Password: $password');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch(e) {
      debugPrint(e.code);
      switch(e.code) {
        case 'user-not-found':
          return 'User does not exist';
        case 'invalid-password':
          return 'The password is invalid';
        default:
          return e.code;
      }
    }
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> resgister({required String email, required String password}) async {
    debugPrint('Name: $email, Password: $password');
    try {
      return Future.delayed(delay).then((_) async {
        await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        return null;
      });
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}