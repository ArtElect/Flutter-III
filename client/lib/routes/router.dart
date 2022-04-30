import 'package:client/routes/routes.dart';
import 'package:client/screens/signin.dart';
import 'package:client/screens/web/home/big_home.dart';
import 'package:client/screens/web/group/big_groups.dart';
import 'package:client/screens/web/project/big_projects.dart';
import 'package:client/screens/web/project/big_project_detail.dart';
import 'package:client/screens/web/project/big_project_create.dart';
import 'package:client/screens/web/project/big_project_update.dart';
import 'package:client/screens/web/profile/big_profile.dart';
import 'package:client/screens/mobile/home/small_home.dart';
import 'package:client/screens/mobile/profile/small_profile.dart';
import 'package:client/screens/mobile/project/small_project.dart';
import 'package:client/services/fire_auth.dart';
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

  Route verifyRoute(RouteSettings settings, Widget mobile, Widget web) {
    if(_fireAuthService.isLogged) {
      if(!kIsWeb) {
        return routeBuilder(settings, mobile);
      } else {
        return routeBuilder(settings, web);
      }
    }
    return unknownPage();
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return verifyRoute(settings, const SmallHomePage(), const BigHomePage());
      case Routes.groups:
        return routeBuilder(settings, const BigGroupsPage());
      case Routes.projects:
        return verifyRoute(settings, const SmallProject(), const BigProjectsPage());
      case Routes.projectDetail:
        return routeBuilder(settings, const BigProjectDetailPage());
      case Routes.projectCreate:
        return routeBuilder(settings, const BigProjectCreatePage());
      case Routes.projectUpdate:
        return routeBuilder(settings, const BigProjectUpdatePage());
      case Routes.profile:
        return verifyRoute(settings, const SmallProfilePage(), const BigProfilePage());
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