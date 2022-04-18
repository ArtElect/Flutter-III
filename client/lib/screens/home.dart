import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:client/components/navbar/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Views to display

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Dashboard")
    );
  }
}
