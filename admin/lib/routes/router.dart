import 'package:admin/routes/routes.dart';
import 'package:admin/screens/groups/groups.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/profile/profile.dart';
import 'package:admin/screens/project/project.dart';
import 'package:admin/screens/roles/roles.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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

  Route isLogged(RouteSettings settings, Widget child) {
    if(_fireAuthService.isLogged) {
        return routeBuilder(settings, child);
    } else {
      return unknownPage();
    }
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return isLogged(settings, const HomePage());
      case Routes.groups:
        return isLogged(settings, const GroupsPage());
      case Routes.projects:
        return isLogged(settings, const ProjectPage());
      case Routes.roles:
        return isLogged(settings, const RolesPage());
      case Routes.profile:
        return isLogged(settings, const ProfilePage());
      case Routes.login:
        return routeBuilder(settings, const LoginPage());
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