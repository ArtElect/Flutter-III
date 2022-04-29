import 'package:admin/models/project_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProjectService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final FireAuthService _fireAuthService = FireAuthService();
  final client = Dio();
  
  Future<List<ProjectModel>> fetchProjects() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/projects',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<ProjectModel> projects = [];
      for(var data in json) {
        projects.add(ProjectModel.fromJson(data));
      }
      return projects;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch projects from database');
    }
  }

  Future<String> createProject(String name, String description, String imageUrl, String groupId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'title': name,
      'description': description,
      'image': imageUrl,
    };
    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects',
      data: data,
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      if (json['message'] != null) print(json['message']);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to create project in database');
    }
  }

  Future<String> updateProject(String title, String description, String imageUrl, String groupId, String projectId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'title': title,
      'description': description,
      'image': imageUrl,
    };
    final response = await client.patch(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects/$projectId',
      data: data,
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      if (json['message'] != null) print(json['message']);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to update project in database');
    }
  }

  Future<String> deleteGroup(String groupId, String projectId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.delete(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId/projects/$projectId',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      if (json['message'] != null) print(json['message']);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to delete project in database');
    }
  }
}