import 'package:adaptive_widgets/adaptive_widgets.dart';
import 'package:client/models/firebase_user_model.dart';
import 'package:client/screens/web/home/home.dart';
import 'package:client/screens/mobile/home/small_home.dart';
import 'package:client/screens/signin.dart';
import 'package:client/services/fire_auth.dart';
import 'package:client/utils/secure_storage.dart';
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
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<FirebaseUserModel?>(
        stream: _fireAuthService.authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.data != null && isLogged == 'true') {
            if (AdaptiveWidget.isSmallScreen(screenSize)) return const SmallHomePage();
            return const HomePage();
          } else {
            return const SignIn();
          }
        },
      ),
    );
  }
}