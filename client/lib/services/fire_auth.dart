
import 'package:client/models/user_model.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SecureStorage _storage = SecureStorage();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  Duration delay = const Duration(milliseconds: 1500);

  UserModel? _fetchUserData(User? user) => user != null ? UserModel(uid: user.uid, email: user.email) : null;
  UserModel? get getCurrentUser => _fetchUserData(_firebaseAuth.currentUser);
  Stream<UserModel?> get authStateChanges => _firebaseAuth.authStateChanges().map(_fetchUserData);
  Future<String>? get getIdToken => _firebaseAuth.currentUser?.getIdToken();
  bool get isLogged => _firebaseAuth.currentUser != null ? true : false;

  Future<String?> createAccountInDB(String token) async {
    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      if (json['message'] != null) print(json['message']);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to create account in database');
    }
  }

  Future<String?> signIn({required String email, required String password}) async {
    debugPrint('Name: $email, Password: $password');
    try {
      _storage.writeSecureData('isLogged', 'true');
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
    _storage.deleteSecureData('isLogged');
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