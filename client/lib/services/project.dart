import 'package:client/models/group_projects_model.dart';
import 'package:client/models/project_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/services/fire_auth.dart';
import 'dart:math';

class ProjectService {
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  final _random = Random();
  List<GroupProjectsModel> groupProjects = [];
  List<ProjectModel> activeProjects = [];

  Future<List<GroupProjectsModel>> getGroupsProjects() async {
    try {
      String? token = await _fireAuthService.getIdToken;
      final response = await client.get(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/projects',
        options: Options(
          headers: {'Authorization':'Bearer $token'},
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

  List<ProjectModel> getActiveGroupsProjects(List<GroupProjectsModel> groups) {
    const int max = 7;

    for (var group in groups) {
      if (group.projects.isNotEmpty) {
        var index = _random.nextInt(group.projects.length);
        activeProjects.add(group.projects[index]);
        if (activeProjects.length >= max) {
          return activeProjects;
        }
      }
    }
    return activeProjects;
  }

  GroupProjectsModel getProjectsByGroupId(String groupId) {
      List<GroupProjectsModel> group = groupProjects.where((group) => group.id == groupId).toList();
      return group[0];
  }
}
