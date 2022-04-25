import 'package:admin/components/sidebar.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/widgets/custom_app_bar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Row(
        children: [
          const Sidebar(selectedIndex: 3),
          Expanded(
            child: Center(
              child: GFButton(
                text: 'Log out',
                size: GFSize.LARGE,
                textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                onPressed: () {
                  FireAuthService().signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}