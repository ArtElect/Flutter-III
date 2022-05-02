import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/services/fire_auth.dart';
import 'package:client/models/group_projects_model.dart';
import 'package:client/models/project_model.dart';
import 'package:client/models/right_model.dart';
import 'dart:math';

class ProjectService {
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost =
      kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  List<GroupProjectsModel> groupProjects = [];
  List<ProjectModel> activeProjects = [];

  Future<List<GroupProjectsModel>> getGroupsProjects() async {
    try {
      String? token = await _fireAuthService.getIdToken;
      final response = await client.get(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/projects',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        final json = response.data;
        for (var data in json) {
          groupProjects.add(GroupProjectsModel.fromJSON(data));
        }
      }
      getActiveGroupsProjects(groupProjects);
      return groupProjects;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> createGroupProject({
    required String groupId,
    required ProjectModel project,
  }) async {
    try {
      String? token = await _fireAuthService.getIdToken;
      Map<String, dynamic> data = {
        "title": project.title,
        "description": project.description,
        "image": project.image,
      };
      final response = await client.post(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> updateGroupProject({
    required String groupId,
    required ProjectModel project,
  }) async {
    try {
      String? token = await _fireAuthService.getIdToken;
      Map<String, dynamic> data = {
        "title": project.title,
        "description": project.description,
        "image": project.image,
      };
      final response = await client.patch(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects/${project.id}',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> deleteGroupProject({
    required String groupId,
    required String projectId,
  }) async {
    try {
      String? token = await _fireAuthService.getIdToken;
      final response = await client.delete(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects/$projectId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  List<ProjectModel> getActiveGroupsProjects(List<GroupProjectsModel> groups) {
    const int max = 7;

    for (var group in groups) {
      if (group.projects.isNotEmpty) {
        for (var project in group.projects) {
          activeProjects.add(project);
          if (activeProjects.length >= max) {
            return activeProjects;
          }
        }
      }
    }
    return activeProjects;
  }

  GroupProjectsModel getProjectsByRoleId({required String roleId}) {
    List<GroupProjectsModel> group =
        groupProjects.where((group) => group.id == roleId).toList();
    return group[0];
  }

  ProjectModel getProjectByRoleIdAndProjectId({
    required String roleId,
    required String projectId,
  }) {
    GroupProjectsModel group = getProjectsByRoleId(roleId: roleId);
    List<ProjectModel> projects =
        group.projects.where((project) => project.id == projectId).toList();
    return projects[0];
  }
}
