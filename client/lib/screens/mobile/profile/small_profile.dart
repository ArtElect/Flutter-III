import 'package:client/routes/routes.dart';
import 'package:client/screens/mobile/drawer/navigation_drawer.dart';
import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SmallProfilePage extends StatefulWidget {
  const SmallProfilePage({ Key? key }) : super(key: key);

  @override
  _SmallProfilePageState createState() => _SmallProfilePageState();
}

class _SmallProfilePageState extends State<SmallProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      body: Center(
        child: GFButton(
          text: 'Log out',
          size: GFSize.LARGE,
          textStyle: const TextStyle(fontSize: 30),
          onPressed: () {
            FireAuthService().signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.signin, (Route<dynamic> route) => false);
          }
        ),
      ),
    );
  }
}