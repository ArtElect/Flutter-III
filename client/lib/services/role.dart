import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/services/fire_auth.dart';
import 'package:client/services/project.dart';
import 'package:client/models/role_model.dart';
import 'package:client/models/right_model.dart';
import 'package:client/models/project_model.dart';

class RoleService {
  final ProjectService _projectService = ProjectService();
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  List<RoleModel> roles = [];
  List<ProjectModel> activeProjects = [];


  Future<List<RoleModel>> getRoles() async {
    try {
      String? token = await _fireAuthService.getIdToken;

      await _projectService.getGroupsProjects();
      activeProjects = _projectService.activeProjects;

      final response = await client.get(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles',
        options: Options(
          headers: {'Authorization':'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final json = response.data;
        for (var data in json) {
          roles.add(RoleModel.fromJSON(data));
        }
      }
      return roles;
    } catch (error, stacktrace) {
      debugPrint('Error : ' +  error.toString() + '\n Stacktrace :' + stacktrace.toString());
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  List<RightModel> getRightsByGroupId({required String groupId}) {
    for (var role in roles) {
      if (role.id == groupId) {
        return role.rights;
      }      
    }
    return [];
  }
}
