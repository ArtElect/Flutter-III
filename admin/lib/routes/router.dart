import 'package:admin/models/groups_model.dart';
import 'package:admin/models/project_model.dart';
import 'package:admin/models/roles_model.dart';
import 'package:admin/routes/routes.dart';
import 'package:admin/screens/groups/add_group.dart';
import 'package:admin/screens/groups/group_detail.dart';
import 'package:admin/screens/groups/groups.dart';
import 'package:admin/screens/home/home.dart';
import 'package:admin/screens/home/user_information.dart';
import 'package:admin/screens/login/login.dart';
import 'package:admin/screens/profile/profile.dart';
import 'package:admin/screens/project/add_project.dart';
import 'package:admin/screens/project/project.dart';
import 'package:admin/screens/project/project_detail.dart';
import 'package:admin/screens/roles/add_role.dart';
import 'package:admin/screens/roles/assign_role.dart';
import 'package:admin/screens/roles/role_detail.dart';
import 'package:admin/screens/roles/roles.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:admin/models/db_user_model.dart';
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
      case Routes.userInformation:
        final dbUserModel = settings.arguments as DbUserModel;
        return isLogged(settings, UserInformationPage(dbUserModel: dbUserModel));
      case Routes.groups:
        return isLogged(settings, const GroupsPage());
      case Routes.groupDetail:
        final groupsModel = settings.arguments as GroupsModel;
        return isLogged(settings, GroupsDetailPage(groupsModel: groupsModel));
      case Routes.addGroup:
        return isLogged(settings, const AddGroupPage());
      case Routes.projects:
        return isLogged(settings, const ProjectPage());
      case Routes.projectDetail:
        final project = settings.arguments as ProjectModel;
        return isLogged(settings, ProjectDetailPage(project: project));
      case Routes.addProject:
        return isLogged(settings, const AddProjectPage());
      case Routes.roles:
        return isLogged(settings, const RolesPage());
      case Routes.rolesDetail:
        final role = settings.arguments as RolesModel;
        return isLogged(settings, RoleDetailPage(role: role,));
      case Routes.addRoles:
        return isLogged(settings, const AddRolePage());
      case Routes.assignRole:
        return isLogged(settings, const AssignRolePage());
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