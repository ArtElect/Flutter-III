import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/services/fire_auth.dart';
import 'package:client/services/role.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/role_model.dart';

class ProfileService {
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost =
      kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  final _roleService = RoleService();
  List<RoleModel> roles = [];

  Future<UserModel> getUserInformation() async {
    try {
      String? token = await _fireAuthService.getIdToken;

      await _roleService.getRoles();
      roles = _roleService.roles;

      final response = await client.get(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final json = response.data;
      var data = UserModel.fromJSON(json);

      return data;
    } catch (error, stacktrace) {
      debugPrint('Error : ' +
          error.toString() +
          '\n Stacktrace :' +
          stacktrace.toString());
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<bool> updateUserInformation({required FormState user}) async {
    try {
      String? token = await _fireAuthService.getIdToken;
      
      final response = await client.post(
        '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
        data: user,
      );
      print('response.data : ' + response.data.toString());
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
