import 'package:admin/models/roles_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RolesService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final FireAuthService _fireAuthService = FireAuthService();
  final client = Dio();
  
  Future<List<RolesModel>> fetchCurrentUserRoles() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<RolesModel> roles = [];
      for(var data in json) {
        roles.add(RolesModel.fromJson(data));
      }
      return roles;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch roles from database');
    }
  }

  Future<List<RolesModel>> fetchAllUsersRoles() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/admin/roles',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<RolesModel> roles = [];
      for(var data in json) {
        roles.add(RolesModel.fromJson(data));
      }
      return roles;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch all users roles from database');
    }
  }

  Future<String> createGroupRole(String groupId, String roleName, List<String> rightsId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'groupId': groupId,
      'name': roleName,
      'rightsId': rightsId,
    };
    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles',
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
      throw Exception('Failed to create role in database');
    }
  }

  Future<String> assignGroupRoleToUser(String roleId, String accountId) async {
    String token = await _fireAuthService.getIdToken ?? '';

    final response = await client.post(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles/$roleId/assign?accountId=$accountId',
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
      throw Exception('Failed to create role in database');
    }
  }

  Future<String> updateGorupRole(List<String> rightId, String roleId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      'rightsId': rightId,
    };
    final response = await client.patch(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles/$roleId',
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
      throw Exception('Failed to update role in database');
    }
  }

  Future<String> deleteRole(String roleId) async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.delete(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/roles/$roleId',
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
      throw Exception('Failed to delete role in database');
    }
  }
}