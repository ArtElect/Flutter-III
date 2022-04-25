import 'package:flutter/material.dart';
import 'package:client/components/navbar/navbar.dart';
import 'package:client/components/sidebar/sidebar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: const Navbar(),
      body: Row(
        children: const [
          Sidebar(selectedIndex: 3),
          Expanded(
            child: Center(
              child: Text("Profile Page")
            )
          )
        ],
      ),
    );
  }
}