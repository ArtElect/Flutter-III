import 'package:flutter/material.dart';
import 'package:flutter_iii/routes/routes.dart';
import 'package:flutter_iii/screens/groups/groups.dart';
import 'package:flutter_iii/screens/users/users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyAdmin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.groups,
      routes: <String, Widget Function(BuildContext)> {
        Routes.groups: (BuildContext context) => const Groups(),
        Routes.users: (BuildContext context) => const Users(),
        // Routes.signin: (BuildContext context) => const Home(),
        // Routes.signup: (BuildContext context) => const Home(),
      }
    );
  }
}