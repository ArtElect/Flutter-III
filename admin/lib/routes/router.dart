import 'package:admin/routes/routes.dart';
import 'package:admin/screens/groups/groups.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/profile/profile.dart';
import 'package:admin/screens/project/project.dart';
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

  /*Route responsive(RouteSettings settings, Widget mobile, Widget web) {
    if(_fireAuthService.isLogged) {
      if(!kIsWeb) {
        return routeBuilder(settings, mobile);
      } else {
        return routeBuilder(settings, web);
      }
    }
    return unknownPage();
  }*/

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        if(_fireAuthService.isLogged) return routeBuilder(settings, const HomePage());
        return unknownPage();
      case Routes.groups:
        if(_fireAuthService.isLogged) return routeBuilder(settings, const GroupsPage());
        return unknownPage();
      case Routes.projects:
        if(_fireAuthService.isLogged) return routeBuilder(settings, const ProjectPage());
        return unknownPage();
      case Routes.profile:
        if(_fireAuthService.isLogged) return routeBuilder(settings, const ProfilePage());
        return unknownPage();
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