import 'package:client/models/role_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:client/services/fire_auth.dart';

class RoleService {
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  List<RoleModel> roles = [];

  Future<List<RoleModel>> getRoles() async {
    try {
      String? token = await _fireAuthService.getIdToken;

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
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
