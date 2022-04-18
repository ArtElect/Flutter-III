import 'package:client/routes/routes.dart';
import 'package:client/screens/home.dart';
import 'package:client/screens/signin.dart';
import 'package:flutter/material.dart';

class GenerateRoutes {

  static Route routeBuilder(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, _, __) => page,
      transitionsBuilder: (context, opacity, _, child) {
          return FadeTransition(opacity: opacity, child: child);
      },
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return routeBuilder(settings, const HomePage());
      case Routes.signin:
        return routeBuilder(settings, const SignIn());
      default:
        return unknownPage();
    }
  }

  static MaterialPageRoute<dynamic> unknownPage() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error')
        ),
        body: const Center(
          child: Text('Unknown Page'),
        ),
      );
    });
  }
}