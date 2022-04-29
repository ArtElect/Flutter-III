import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FireAuthService _firebaseAuth = FireAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        title: 'EPITECH',
        additionalSignupFields: const [
          UserFormField(
            keyName: 'firstName',
            displayName: 'First Name',
          ),
          UserFormField(
            keyName: 'lastName',
            displayName: 'Last Name',
          ),
          UserFormField(
            keyName: 'pseudo',
            displayName: 'Pseudo',
          ),
        ],
        onLogin: (data) =>
            _firebaseAuth.signIn(email: data.name, password: data.password),
        onSignup: (data) => _firebaseAuth.register(signupData: data),
        onSubmitAnimationCompleted: () =>
            Navigator.popAndPushNamed(context, '/home'),
        hideForgotPasswordButton: true,
        loginAfterSignUp: false,
        onRecoverPassword: (_) => Future(() => null),
      ),
    );
  }
}
