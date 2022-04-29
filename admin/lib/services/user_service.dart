import 'package:admin/models/db_user_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final FireAuthService _fireAuthService = FireAuthService();
  final client = Dio();

  Future<List<DbUserModel>> getAccounts() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/accounts',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<DbUserModel> dbUserModelList = [];
      for (var jsondata in json) {
        dbUserModelList.add(DbUserModel.fromJson(jsondata));
      }
      return dbUserModelList;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch users from database');
    }
  }

  Future<String?> updateCurrentAccount(String firstname, String lastname, String pseudo, String imageUrl) async {
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
      final json = response.data;
      if (json['message'] != null) print(json['message']);
      return json['message'];
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to update current user image in database');
    }
  }
}