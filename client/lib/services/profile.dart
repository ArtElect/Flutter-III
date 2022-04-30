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

  Future<bool> updateCurrentAccount(String firstname, String lastname, String pseudo, String imageUrl) async {
    String token = await _fireAuthService.getIdToken ?? '';
    Map<String, dynamic> data = {
      "firstname": firstname,
      "lastname": lastname,
      "pseudo": pseudo,
      "image": imageUrl,
    };
    final response = await client.patch(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
      data: data,
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      return false;
    }
  }
}
