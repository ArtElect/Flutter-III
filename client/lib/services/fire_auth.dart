import 'dart:convert';
import 'package:client/models/firebase_user_model.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class FireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SecureStorage _storage = SecureStorage();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();

  FirebaseUserModel? _fetchUserData(User? user) => user != null ? FirebaseUserModel(uid: user.uid, email: user.email) : null;
  FirebaseUserModel? get getCurrentUser => _fetchUserData(_firebaseAuth.currentUser);
  Stream<FirebaseUserModel?> get authStateChanges => _firebaseAuth.authStateChanges().map(_fetchUserData);
  Future<String>? get getIdToken => _firebaseAuth.currentUser?.getIdToken(true);
  bool get isLogged => _firebaseAuth.currentUser != null ? true : false;

  Future<String?> createAccountInDB({required SignupData signupData }) async {
    String? token = await getIdToken;
    Map<String, dynamic> data = {
      "firstname": signupData.additionalSignupData?['firstName'],
      "lastname": signupData.additionalSignupData?['lastName'],
      "pseudo": signupData.additionalSignupData?['pseudo'],
    };
    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
      options: Options(
        headers: {
          'Authorization':'Bearer ' + token!,
          'Content-Type':'application/json'
        },
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      final json = response.data;
      print(json);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to create account in database');
    }
  }

  Future<String?> signIn({required String email, required String password}) async {
    debugPrint('Name: $email, Password: $password');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      _storage.writeSecureData('isLogged', 'true');
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
    _storage.deleteSecureData('isLogged');
    await _firebaseAuth.signOut();
  }

  Future<String?> register({required SignupData signupData}) async {
    debugPrint('Name: ${signupData.name}, Password: ${signupData.password}');
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: signupData.name!, password: signupData.password!);
      String? res = await createAccountInDB(signupData: signupData);

      if (res == 'account created') {
        return null;
      } else {
        result.user?.delete();
        return 'Account creation failed, please try again';
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      switch(e.code) {
        case "email-already-in-use":
          return 'The email is already in use';
        case "weak-password":
          return 'Password should be at least 6 characters';
        default:
          return e.code;
      }
    }
  }
}