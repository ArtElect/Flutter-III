import 'package:client/models/firebase_user_model.dart';
import 'package:client/models/role_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/services/fire_auth.dart';

class RoleService {
  final FireAuthService _fireAuthService = FireAuthService();
  final String fireStoreHost = kIsWeb ? 'http://localhost:5001' : 'http://10.0.2.2:5001';
  final client = Dio();

  Future<List<RoleModel>> getRoles() async {
    String? token = await _fireAuthService.getIdToken;
    print(token);
    final response = await client.get(
      'http://localhost:5001/flutter-iii-8a868/us-central1/api/roles',
      options: Options(
        headers: {'Authorization':'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImM2NzNkM2M5NDdhZWIxOGI2NGU1OGUzZWRlMzI1NWZiZjU3NTI4NWIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmx1dHRlci1paWktOGE4NjgiLCJhdWQiOiJmbHV0dGVyLWlpaS04YTg2OCIsImF1dGhfdGltZSI6MTY1MDkyMjI5OCwidXNlcl9pZCI6ImxDVTYySlBaMW9Pa21ISmo4WGo3OEhUZVZiZDIiLCJzdWIiOiJsQ1U2MkpQWjFvT2ttSEpqOFhqNzhIVGVWYmQyIiwiaWF0IjoxNjUwOTIyNDM1LCJleHAiOjE2NTA5MjYwMzUsImVtYWlsIjoiemhpd2VuLndhbmdAZXBpdGVjaC5ldSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ6aGl3ZW4ud2FuZ0BlcGl0ZWNoLmV1Il19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.F9SDzMvkLOKM_7fhExUNp8tOZMwcSKnyfRAQ9kn023yjgVi-QrGEtMeu1c-vxJDimWwnuJSuddytS3aFUs8rWGeXzv2JW45AG1DQ8pCZOnhi8SX5lSH9EqJ6p5jylSGkRQI5izUECdN-6cLZeTgwxW3q7Kd25L04mkyR0TDfVCWOERsvVZfrAs2U5k2W3L85NzGYfFp1KUvEBDL1NmXTSADSVKKF9K9w3PqgwWO4CimK_ZL0GmdJs0k0WoTK1syxj7OJkWBFB9Vp8Gl8hmQ81rqxeITYevYKO7XUTsdlTZhBFMRP2BNLK04zCylEngp8cDHqXD3gAGFkGOfF9uyLLg'},
      ),
    );
    print('code: ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      final json = response.data;
      List<RoleModel> roles = [];

      for (var data in json) {
        roles.add(RoleModel.fromJSON(data));
      }
      return roles;
    } else {
      throw Exception("Failed to load project");
    }
  }
}
