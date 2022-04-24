import 'dart:ui';
import 'package:client/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:client/routes/routes.dart';
import 'package:client/constant/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epitech Dashboard',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: MyColors.purple,
        ),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: (setting) => GenerateRoutes().generateRoute(setting),
    );
  }
}
