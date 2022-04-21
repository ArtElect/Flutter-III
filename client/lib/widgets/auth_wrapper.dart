import 'package:client/screens/layout.dart';
import 'package:client/screens/signin.dart';
import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({ Key? key }) : super(key: key);

  final FireAuthService _fireAuthService = FireAuthService();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder(
        stream: _fireAuthService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const LayoutPage();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}