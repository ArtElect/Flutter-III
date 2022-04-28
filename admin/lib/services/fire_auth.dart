
import 'package:admin/models/db_user_model.dart';
import 'package:admin/utils/secure_storage.dart';
import 'package:admin/models/fire_user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SecureStorage _storage = SecureStorage();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();

  FirebaseUserModel? _fetchUserData(User? user) => user != null ? FirebaseUserModel(uid: user.uid, email: user.email) : null;
  FirebaseUserModel? get getCurrentUser => _fetchUserData(_firebaseAuth.currentUser);
  Stream<FirebaseUserModel?> get authStateChanges => _firebaseAuth.authStateChanges().map(_fetchUserData);
  Future<String>? get getIdToken => _firebaseAuth.currentUser?.getIdToken();
  bool get isLogged => _firebaseAuth.currentUser != null ? true : false;
  
  Future<DbUserModel> fetchCurrentDbUser(String token) async {
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = DbUserModel.fromJson(response.data);
      return json;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch the current user from database');
    }
  }

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
    DbUserModel user;
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      String? res = await createAccountInDB(await result.user!.getIdToken(true));
      DbUserModel user = await fetchCurrentDbUser(await result.user!.getIdToken(true));
      if (res == 'account created' || user.role == 'USER') {
        if (user.role == 'ADMIN') {
          _storage.writeSecureData('isLogged', 'true');
          return null;
        } else {
          await _firebaseAuth.signOut();
          _storage.writeSecureData('isLogged', 'false');
          return 'This is not an administrator account';
        }
      }
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
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      switch(e.code) {
        case 'email-already-in-use':
          return 'The email is already in use';
        case 'weak-password':
          return 'Password should be at least 6 characters';
        default:
          return e.code;
      }
    }
  }
}