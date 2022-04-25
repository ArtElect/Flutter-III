import 'package:admin/models/db_user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();
  
  Future<DbUserModel> fetchDbUser(String token) async {
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/account',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = DbUserModel.fromJson(response.data);
      return json;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch user from database');
    }
  }
}