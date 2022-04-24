import 'package:client/routes/routes.dart';
import 'package:client/screens/signin.dart';
import 'package:client/screens/home.dart';
import 'package:client/screens/groups.dart';
import 'package:client/screens/projects.dart';
import 'package:client/screens/profile.dart';
import 'package:client/screens/mobile/home/small_home.dart';
import 'package:client/screens/mobile/profile/small_profile.dart';
import 'package:client/screens/mobile/project/small_project.dart';
import 'package:client/screens/signIn.dart';
import 'package:client/services/fire_auth.dart';
import 'package:flutter/material.dart';

class GenerateRoutes {
  final FireAuthService _fireAuthService = FireAuthService();

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
      case Routes.groups:
        return routeBuilder(settings, const GroupsPage());
      case Routes.projects:
        return routeBuilder(settings, const ProjectsPage());
      case Routes.profile:
        return routeBuilder(settings, const ProfilePage());
      case Routes.signin:
        return routeBuilder(settings, const SignIn());
      default:
        return unknownPage();
    }
  }

  static MaterialPageRoute<dynamic> unknownPage() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Unknown Page'),
        ),
      );
    });
  }
}