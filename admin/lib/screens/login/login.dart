import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:admin/services/fire_auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FireAuthService _firebaseAuth = FireAuthService();
    
    return Scaffold(
      body: FlutterLogin(
        title: 'EPITECH',
        onLogin: (data) => _firebaseAuth.signIn(email: data.name, password: data.password),
        onSignup: (data) =>  _firebaseAuth.resgister(email: data.name ?? '', password: data.password ?? ''),
        onSubmitAnimationCompleted: () => Navigator.popAndPushNamed(context, '/home'),
        hideForgotPasswordButton: true,
        loginAfterSignUp: false,
        onRecoverPassword: (_) => Future(() => null),
      ),
    );
  }
}