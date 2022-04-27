import 'package:admin/models/rights_model.dart';
import 'package:admin/services/fire_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RightService {
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final FireAuthService _fireAuthService = FireAuthService();
  final client = Dio();

  Future<List<RightsModel>> fetchRights() async {
    String token = await _fireAuthService.getIdToken ?? '';
    final response = await client.get(
      '$fireStoreHost/flutter-iii-8a868/us-central1/api/rights',
      options: Options(
        headers: {'Authorization':'Bearer ' + token},
      ),
    );
    if (response.statusCode == 200) {
      final json = response.data;
      List<RightsModel> rights = [];
      for (var data in json) {
        rights.add(RightsModel.fromJson(data));
      }
      return rights;
    } else {
      print('Status code : ${response.statusCode}, Response data : ${response.data.toString()}');
      throw Exception('Failed to fetch rights from database');
    }
  }
}