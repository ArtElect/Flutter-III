import 'package:admin/models/groups_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GroupService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final FireAuthService _fireAuthService = FireAuthService();
  final client = Dio();
  
  Future<List<GroupsModel>> fetchGroups() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<GroupsModel> groups = [];
      for(var data in json) {
        groups.add(GroupsModel.fromJson(data));
      }
      return groups;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch groups from database');
    }
  }

  Future<String> createGroup(String name, String description, String imageUrl) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'image': imageUrl,
    };
    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups',
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
      throw Exception('Failed to create group in database');
    }
  }

  Future<String> updateGroup(String name, String description, String imageUrl, String groupId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'image': imageUrl,
    };
    final response = await client.patch(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId',
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
      throw Exception('Failed to update group in database');
    }
  }

  Future<String> deleteGroup(String groupId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.delete(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/groups/$groupId',
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
      throw Exception('Failed to delete group in database');
    }
  }
}