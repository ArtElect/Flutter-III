import 'package:admin/models/user_model.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/utils/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({ Key? key }) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final FireAuthService _fireAuthService = FireAuthService();
  final SecureStorage _storage = SecureStorage();
  String? isLogged;
  
  @override
  void initState() {
    _storage.readSecureData("isLogged").then((value) {
      setState(() {
        isLogged = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<UserModel?>(
        stream: _fireAuthService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.data != null && isLogged == 'true') {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}